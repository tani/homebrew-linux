class Acl2 < Formula
  desc "Logic and programming language in which you can model computer systems"
  homepage "https://www.cs.utexas.edu/users/moore/acl2/index.html"
  url "https://github.com/acl2/acl2/archive/8.3.tar.gz"
  sha256 "45eedddb36b2eff889f0dba2b96fc7a9b1cf23992fcfdf909bc179f116f2c5ea"
  license "BSD-3-Clause"

  depends_on "clozure-cl"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-linux"
    cellar :any_skip_relocation
    sha256 "05ab745c17aea88ba083379a2b850313cb0cfef3b3fc9566dc89b76ca00b463b" => :x86_64_linux
  end

  def install
    system "make",
	   "LISP=#{Formula["clozure-cl"].opt_bin}/ccl64",
           "ACL2=#{buildpath}/saved_acl2",
           "USE_QUICKLISP=0",
           "all", "basic"
    libexec.install Dir["*"]

    (bin/"acl2").write <<~EOF
      #!/bin/sh
      export ACL2_SYSTEM_BOOKS='#{libexec}/books'
      exec '#{Formula["clozure-cl"].opt_bin}/ccl64' -I '#{libexec}/saved_acl2.lx86cl64' -Z 64M -K ISO-8859-1 -e '(acl2::acl2-default-restart)' "$@"
    EOF
  end

  test do
    (testpath/"simple.lisp").write "(+ 2 2)"
    output = shell_output("#{bin}/acl2 < #{testpath}/simple.lisp | grep 'ACL2 !>'")
    assert_equal "ACL2 !>4\nACL2 !>Bye.", output.strip
  end
end
