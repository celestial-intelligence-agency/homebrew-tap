class Scribe < Formula
  desc "Tool-agnostic AI session scribe — watches coding transcripts and extracts structured knowledge"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  version "0.1.2"
  url "https://downloads.celestialintelligence.co/scribe/scribe-v#{version}/scribe-aarch64.tar.gz"
  sha256 "25d94911736e07765a23384730259d58bdba13bc67b910f57304233e53a45076"
  license "MIT"

  depends_on "node@22"
  depends_on arch: :arm64

  def install
    libexec.install Dir["*"]

    (bin/"scribe").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@22"].opt_bin}:$PATH"
      exec node "#{libexec}/dist/cli.js" "$@"
    EOS
  end

  test do
    assert_match "scribe", shell_output("#{bin}/scribe --help 2>&1", 0).downcase
  end
end
