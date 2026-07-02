class Ct < Formula
  desc "Per-machine config operator CLI (ADR-071 P2) — `ct config {init,edit,get,set,show,path}`"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  url "https://downloads.celestialintelligence.co/ct/ct-v0.1.0/ct-aarch64.tar.gz"
  version "0.1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"

  depends_on "node@22"
  depends_on arch: :arm64

  def install
    libexec.install Dir["*"]

    (bin/"ct").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@22"].opt_bin}:$PATH"
      exec node "#{libexec}/dist/cli.js" "$@"
    EOS
  end

  test do
    assert_match "ct", shell_output("#{bin}/ct --help 2>&1", 0).downcase
  end
end
