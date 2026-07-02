class HarnessCli < Formula
  desc "Federated harness search + install (ADR-050 Phase 4) — `celestial-harness` (and `ch` alias)"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  url "https://downloads.celestialintelligence.co/harness-cli/harness-v0.1.0/harness-cli-aarch64.tar.gz"
  version "0.1.0"
  sha256 "fc3cff14ee72a90fe188ee21f8530f8ffcefb55d4efcd5b51431298170834875"
  license "MIT"

  depends_on "node@22"
  depends_on arch: :arm64

  def install
    libexec.install Dir["*"]

    (bin/"celestial-harness").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@22"].opt_bin}:$PATH"
      exec node "#{libexec}/dist/cli.js" "$@"
    EOS

    bin.install_symlink "celestial-harness" => "ch"
  end

  test do
    assert_match "harness", shell_output("#{bin}/celestial-harness --help 2>&1", 0).downcase
  end
end
