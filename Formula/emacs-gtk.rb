class EmacsGtk < Formula
  url "https://ftp.gnu.org/gnu/emacs/emacs-27.1.tar.xz"
  mirror "https://ftpmirror.gnu.org/emacs/emacs-27.1.tar.xz"
  sha256 "4a4c128f915fc937d61edfc273c98106711b540c9be3cd5d2e2b9b5b2f172e41"

  head do
    url "https://github.com/emacs-mirror/emacs.git", :branch => "emacs-27"
  end

  depends_on "autoconf" => :build
  depends_on "gnu-sed" => :build
  depends_on "pkg-config" => :build
  depends_on "texinfo" => :build
  depends_on "gnutls"
  depends_on "jansson"
  depends_on "little-cms2"
  depends_on "librsvg"
  depends_on "giflib"
  depends_on "libxpm"
  depends_on "jpeg"
  depends_on "libtiff"
  depends_on "libpng"
  depends_on "cairo"
  depends_on "imagemagick"
  depends_on "freetype"
  depends_on "fontconfig"
  depends_on "gtk+3"
  depends_on "harfbuzz"
  depends_on "dbus"
  depends_on "mailutils"

  def install
    args = %W[
      --disable-silent-rules
      --enable-locallisppath=#{HOMEBREW_PREFIX}/share/emacs/site-lisp
      --infodir=#{info}/emacs
      --prefix=#{prefix}
      --with-xml2
      --with-gnutls
      --with-x
      --with-x-toolkit=gtk3
      --with-cairo
      --with-harfbuzz
      --with-imagemagick
      --with-modules
      --with-rsvg
      --with-dbus
    ]

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "4", shell_output("#{bin}/emacs --batch --eval=\"(print (+ 2 2))\"").strip
  end
end
