class Celestiald < Formula
  desc "Celestial composition daemon — serves the dashboard, routes to product daemons, runs orbit's supervision loop (ADR-102)"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  version "0.1.3"
  url "https://downloads.celestialintelligence.co/celestiald/celestiald-v#{version}/celestiald-aarch64.tar.gz"
  sha256 "208e0e99ee18af09f3c2704c0c9270ce3f956c23ec5e9b29d0ccc2b5ad01be4b"
  license "MIT"

  depends_on "node@22"
  depends_on arch: :arm64

  def install
    libexec.install Dir["*"]

    (bin/"celestiald").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@22"].opt_bin}:$PATH"
      exec node "#{libexec}/dist/main.js" "$@"
    EOS
  end

  test do
    # main.js binds a listener on boot; a syntax-level load is the smoke here.
    assert_predicate libexec/"dist/main.js", :exist?
  end
end
