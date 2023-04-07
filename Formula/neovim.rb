class Neovim < Formula
  desc "hyperextensible Vim-based text editor"
  homepage "https://neovim.io"
  url "https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"
  sha256 "d18fdb2e76adfc3e438915f7b4b226041a8a2bfcd2d158304e441b4acfbb9b24"
  license "Apache"

  def install
    prefix.install Dir["*"]
  end

  def test
    system "nvim --version"
  end
end
