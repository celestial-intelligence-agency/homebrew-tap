class Scribe < Formula
  desc "Tool-agnostic AI session scribe — watches coding transcripts and extracts structured knowledge"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  url "https://downloads.celestialintelligence.co/scribe/scribe-v0.1.0/scribe-aarch64.tar.gz"
  version "0.1.0"
  sha256 "d6f2b232d2836c3f6e2e7b2f87ab6caa3c6bd646d324907d06350cea7ad01ff8"
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
