# Homebrew formula for the `cleaner` CLI.
#
# Lives in a single tap repo named "homebrew-cleaner" that also holds the
# source (bin/cleaner). After you push the repo and tag a release, replace
# victorshablyko below with your GitHub username and paste the tarball sha256.
#
# Compute the sha256 after pushing tag v0.1.0:
#   curl -sL https://github.com/victorshablyko/homebrew-cleaner/archive/refs/tags/v0.1.2.tar.gz | shasum -a 256
#
# Then users install with:
#   brew tap victorshablyko/cleaner
#   brew install cleaner
class Cleaner < Formula
  desc "Strip developer-machine metadata from an Xcode project before transfer"
  homepage "https://github.com/victorshablyko/homebrew-cleaner"
  url "https://github.com/victorshablyko/homebrew-cleaner/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "20fde71a50c590f2940e37170baf04775fe1f8036d6df2da8f2cebb7edcd9493"
  version "0.1.2"
  license "MIT"

  def install
    bin.install "bin/cleaner"
  end

  test do
    assert_match "cleaner v#{version}", shell_output("#{bin}/cleaner version")
  end
end
