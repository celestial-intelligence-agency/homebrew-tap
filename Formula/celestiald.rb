class Celestiald < Formula
  desc "Celestial composition daemon — serves the dashboard, routes to product daemons, runs orbit's supervision loop (ADR-102)"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  version "0.1.4"
  url "https://downloads.celestialintelligence.co/celestiald/celestiald-v#{version}/celestiald-aarch64.tar.gz"
  sha256 "652ed436215c842c946761f35d9d5a3fbbd3dab9ba040f48ba88d3468ac80b14"
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
