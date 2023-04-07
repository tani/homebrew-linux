class Neovim < Formula
  desc "hyperextensible Vim-based text editor"
  homepage "https://neovim.io"
  head "https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz", using: :curl
  license "Apache"

  def install
    prefix.install Dir["*"]
  end

  def test
    system "nvim --version"
  end
end
