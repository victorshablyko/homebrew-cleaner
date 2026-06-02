# Homebrew formula for the `cleaner` CLI.
#
# Lives in a single tap repo named "homebrew-cleaner" that also holds the
# source (bin/cleaner). After you push the repo and tag a release, replace
# victorshablyko below with your GitHub username and paste the tarball sha256.
#
# Compute the sha256 after pushing tag v0.1.0:
#   curl -sL https://github.com/victorshablyko/homebrew-cleaner/archive/refs/tags/v0.1.0.tar.gz | shasum -a 256
#
# Then users install with:
#   brew tap victorshablyko/cleaner
#   brew install cleaner
class Cleaner < Formula
  desc "Strip developer-machine metadata from an Xcode project before transfer"
  homepage "https://github.com/victorshablyko/homebrew-cleaner"
  url "https://github.com/victorshablyko/homebrew-cleaner/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "8da8743183411d38503bd200365a1c74cb4968034ac872de540f51b3e3a02a3d"
  version "0.1.0"
  license "MIT"

  def install
    bin.install "bin/cleaner"
  end

  test do
    assert_match "cleaner v#{version}", shell_output("#{bin}/cleaner version")
  end
end
