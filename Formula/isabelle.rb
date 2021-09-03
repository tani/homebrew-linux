class Isabelle < Formula
  desc "Isabelle is a generic proof assistant with Emacs support."
  homepage "https://isabelle.in.tum.de"
  head "git://github.com/m-fleury/isabelle-emacs", branch: "Isabelle2021-more-vscode"
  license "BSD-3-Clause"

  def install
    libexec.install Dir["*"]
    system [libexec/"bin"/"isabelle", "components", "-I"]
    system [libexec/"bin"/"isabelle", "components", "-a"]
    system [libexec/"bin"/"isabelle", "build", "-b", "HOL"]
    bin.install_symlink libexec/"bin"/"isabelle"
  end

  test do
    system "isabelle"
  end
end
