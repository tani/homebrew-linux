class Isabelle < Formula
  desc "Isabelle is a generic proof assistant."
  homepage "https://isabelle.in.tum.de"
  url "https://mirror.clarkson.edu/isabelle/dist/Isabelle2020_linux.tar.gz"
  version "2020"
  sha256 "633aff864d6647bd175cf831e7513e3fd0cd06beacbf29a5c6c66d4de1522bae"
  license "BSD-3-Clause"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin"/"isabelle"
  end

  test do
    system "isabelle"
  end
end
