class Acl2 < Formula
  desc "Logic and programming language in which you can model computer systems"
  homepage "https://www.cs.utexas.edu/users/moore/acl2/index.html"
  url "https://github.com/acl2/acl2/archive/8.3.tar.gz"
  sha256 "45eedddb36b2eff889f0dba2b96fc7a9b1cf23992fcfdf909bc179f116f2c5ea"
  license "BSD-3-Clause"

  depends_on "clozure-cl"
  depends_on "openssl"
  depends_on "z3"

  def install
    suffix =
      if OS.mac?
        "dx86cl64"
      elsif OS.linux?
        "lx86cl64"
      end

    system "make",
      "LISP=#{Formula["clozure-cl"].opt_bin}/ccl64",
      "ACL2_PAR=p",
      "ACL2_REAL=r",
      "ACL2=#{buildpath}/saved_acl2pr",
      "USE_QUICKLISP=1",
      "all", "basic"
    libexec.install Dir["*"]

    (bin/"acl2").write <<~EOF
      #!/bin/sh
      export ACL2_SYSTEM_BOOKS='#{libexec}/books'
      exec '#{Formula["clozure-cl"].opt_bin}/ccl64' -I '#{libexec}/saved_acl2pr.#{suffix}' -Z 64M -K ISO-8859-1 -e '(acl2::acl2-default-restart)' "$@"
    EOF
  end

  test do
    (testpath/"simple.lisp").write "(+ 2 2)"
    output = shell_output("#{bin}/acl2 < #{testpath}/simple.lisp | grep 'ACL2(r) !>'")
    assert_equal "ACL2(r) !>4\nACL2(r) !>Bye.", output.strip
  end
end
