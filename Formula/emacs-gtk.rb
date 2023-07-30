class EmacsGtk < Formula
  url "https://ftp.gnu.org/gnu/emacs/emacs-29.1.tar.xz"
  mirror "https://ftpmirror.gnu.org/emacs/emacs-29.1.tar.xz"
  sha256 "d2f881a5cc231e2f5a03e86f4584b0438f83edd7598a09d24a21bd8d003e2e01"

  head do
    url "https://github.com/emacs-mirror/emacs.git", :branch => "master"
  end

  depends_on "autoconf" => :build
  depends_on "gnu-sed" => :build
  depends_on "pkg-config" => :build
  depends_on "texinfo" => :build
  depends_on "make" => :build
  depends_on "autoconf" => :build
  depends_on "gnu-sed" => :build
  depends_on "gnu-tar" => :build
  depends_on "grep" => :build
  depends_on "awk" => :build
  depends_on "coreutils" => :build
  depends_on "xz" => :build
  depends_on "libgccjit"
  depends_on "libxaw"
  depends_on "gnutls"
  depends_on "gcc"
  depends_on "gmp"
  depends_on "zlib"
  depends_on "jansson"
  depends_on "little-cms2"
  depends_on "tree-sitter"
  depends_on "librsvg"
  depends_on "giflib"
  depends_on "libxpm"
  depends_on "sqlite"
  depends_on "jpeg"
  depends_on "libtiff"
  depends_on "libpng"
  depends_on "cairo"
  depends_on "imagemagick"
  depends_on "freetype"
  depends_on "fontconfig"
  depends_on "gtk+3"
  depends_on "webkitgtk"
  depends_on "harfbuzz"
  depends_on "dbus"
  depends_on "mailutils"
  depends_on "webp"

  def install
    args = %W[
      --disable-silent-rules
      --enable-locallisppath=#{HOMEBREW_PREFIX}/share/emacs/site-lisp
      --infodir=#{info}/emacs
      --prefix=#{prefix}
      --with-native-compilation=aot
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
      --with-small-ja-dic
      --with-xwidgets
      
    ]

    ENV.append "CPATH", "-I#{Formula["libgccjit"].opt_include}"
    ENV.append "LDFLAGS", "-L#{Formula["libgccjit"].opt_lib}/gcc/current"
    ENV.append "LD_LIBRARY_PATH", "#{Formula["libgccjit"].opt_lib}/gcc/current"
    
    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "4", shell_output("#{bin}/emacs --batch --eval=\"(print (+ 2 2))\"").strip
  end
end
