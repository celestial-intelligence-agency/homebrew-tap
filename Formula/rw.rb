class Rw < Formula
  desc "Policy-driven workspace janitor (`rw`)"
  homepage "https://github.com/celestial-intelligence-agency/roger-wilco"
  version "0.1.0"
  url "https://github.com/celestial-intelligence-agency/roger-wilco/releases/download/rw-v#{version}/rw-#{version}.tar.gz"
  sha256 "45a710f9bcd68bb69f18ef0f15e27d7b4960b5cbd493c7ccf59e2a02cefc8f99"
  license "MIT"

  depends_on "node@22"

  def install
    libexec.install Dir["*"]
    (bin/"rw").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@22"].opt_bin}:$PATH"
      exec node "#{libexec}/rw.cjs" "$@"
    EOS
  end

  test do
    assert_match "inventory", shell_output("#{bin}/rw help")
  end
end
