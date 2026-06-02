# Homebrew formula for the `cleaner` CLI.
#
# Lives in a single tap repo named "homebrew-cleaner" that also holds the
# source (bin/cleaner). After you push the repo and tag a release, replace
# victorshablyko below with your GitHub username and paste the tarball sha256.
#
# Compute the sha256 after pushing tag v0.1.0:
#   curl -sL https://github.com/victorshablyko/homebrew-cleaner/archive/refs/tags/v0.1.1.tar.gz | shasum -a 256
#
# Then users install with:
#   brew tap victorshablyko/cleaner
#   brew install cleaner
class Cleaner < Formula
  desc "Strip developer-machine metadata from an Xcode project before transfer"
  homepage "https://github.com/victorshablyko/homebrew-cleaner"
  url "https://github.com/victorshablyko/homebrew-cleaner/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "21f4948be7dc4d3d16d7cc0132e89ee541e6a83a5e61d2606168c131a5927cb4"
  version "0.1.1"
  license "MIT"

  def install
    bin.install "bin/cleaner"
  end

  test do
    assert_match "cleaner v#{version}", shell_output("#{bin}/cleaner version")
  end
end
