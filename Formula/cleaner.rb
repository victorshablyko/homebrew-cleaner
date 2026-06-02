# Homebrew formula for the `cleaner` CLI.
#
# Lives in a single tap repo named "homebrew-cleaner" that also holds the
# source (bin/cleaner). After you push the repo and tag a release, replace
# GH_USER below with your GitHub username and paste the tarball sha256.
#
# Compute the sha256 after pushing tag v0.1.0:
#   curl -sL https://github.com/GH_USER/homebrew-cleaner/archive/refs/tags/v0.1.0.tar.gz | shasum -a 256
#
# Then users install with:
#   brew tap GH_USER/cleaner
#   brew install cleaner
class Cleaner < Formula
  desc "Strip developer-machine metadata from an Xcode project before transfer"
  homepage "https://github.com/GH_USER/homebrew-cleaner"
  url "https://github.com/GH_USER/homebrew-cleaner/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "REPLACE_WITH_TARBALL_SHA256"
  version "0.1.0"
  license "MIT"

  def install
    bin.install "bin/cleaner"
  end

  test do
    assert_match "cleaner v#{version}", shell_output("#{bin}/cleaner version")
  end
end
