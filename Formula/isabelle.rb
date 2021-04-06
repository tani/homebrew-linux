class Isabelle < Formula
  desc "Isabelle is a generic proof assistant with Emacs support."
  homepage "https://isabelle.in.tum.de"
  head "git://github.com/m-fleury/isabelle-release", branch: "Isabelle2021-more-vscode"
  license "BSD-3-Clause"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin"/"isabelle"
  end

  test do
    system "isabelle"
  end
end
