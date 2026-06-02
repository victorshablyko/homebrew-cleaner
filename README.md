# cleaner

A small command-line tool that strips developer-machine metadata from an Xcode
project before it is archived and transferred to an isolated build machine
(one Apple Developer account per machine).

It is a thin, transparent wrapper around `rm`, `find`, `xattr`, `zip` and
`pod install` — you can read exactly what it does in [`bin/cleaner`](bin/cleaner).

## Why

When you build and upload on a separate machine per Apple account, you want the
transferred project to carry **no traces of the source machine** (absolute
`/Users/...` paths, Xcode user state, macOS extended attributes). `cleaner`
standardizes that cleanup so it is repeatable and safe.

> Note: file cleanup is hygiene, not invisibility. Apple links accounts mainly
> via the machine you sign in with, the account/payment data, IP, and reused
> SDK identifiers — not via `.DS_Store`. Keep one machine + one identity per
> account.

## Install

```bash
brew tap your-org/cleaner
brew install cleaner
```

Or run it locally without Homebrew:

```bash
git clone https://github.com/your-org/cleaner.git
sudo ln -sf "$PWD/cleaner/bin/cleaner" /usr/local/bin/cleaner
```

## Workflow

On the **source** machine (where you write code):

```bash
# Safest: copy a clean project to a new folder, original is never touched
cd /path/to/ProjectFolder
cleaner export                 # creates ../ProjectFolder-clean (clean copy)
cd ../ProjectFolder-clean
cleaner check
cleaner pack                   # optional: ../ProjectFolder-clean.zip (encrypted)

# Or clean the original in place (relies on git to recover tracked files)
cd /path/to/ProjectFolder
cleaner clean
cleaner check
cleaner pack
```

Transfer the archive to the build machine (e.g. via your file channel), then on
the **build** machine (real Mac with the Apple Developer account):

```bash
cd /path/to/ProjectFolder
cleaner prepare      # xattr -cr + fresh pod install / SwiftPM resolve
# open in Xcode → Clean Build Folder → Archive → upload via Transporter
```

After a successful upload:

```bash
cleaner purge        # delete the project folder + its DerivedData
```

## Commands

| Command   | Where    | What it does |
|-----------|----------|--------------|
| `clean`   | source   | Removes build/, DerivedData/, xcuserdata, `*.xcuserstate`, `.swiftpm/`, logs, `.DS_Store`, `._*`, `Pods/` (configurable), strips xattrs. **Keeps `Package.resolved` and `Podfile.lock`.** Edits the original in place. |
| `export`  | source   | Copies a CLEAN project to a new folder (default `../<name>-clean`) via `rsync` with excludes, then strips xattrs. **The original is never modified** — safest option. |
| `prepare` | build    | `xattr -cr .`, then `pod install` / `swift package resolve` if needed. |
| `check`   | both     | Prints xattrs, personal paths, Xcode garbage, total size. |
| `pack`    | source   | Creates an encrypted `../<name>.zip`. |
| `purge`   | build    | Deletes the project folder + matching DerivedData (with confirmation). |

## Flags

- `--dry-run` — print actions without executing them
- `-y, --yes` — skip confirmations (destructive ops)
- `--force` — run even if the folder has no Xcode project markers
- `--git` — (with `clean`) also remove `.git/` after a clean `git status`
- `--keep-pods` — (with `clean`) keep `Pods/`

## Config

Drop a `.cleaner.yml` in the project root (see `.cleaner.yml.example`):

```yaml
project_name: AuroraVPN
strip_pods: true
strip_git: false
pack_name: AuroraVPN
```

## Safety

- Refuses to run destructive commands unless the directory looks like an Xcode
  project (`*.xcodeproj` / `*.xcworkspace` / `Podfile` / `Package.swift`),
  unless `--force` is given.
- Never uses blanket `*.log` / `*.txt` deletion — only narrow `build*.log`
  patterns.
- `.git/` removal requires a clean status, a configured remote, and confirmation.
- Use `--dry-run` first if unsure.
