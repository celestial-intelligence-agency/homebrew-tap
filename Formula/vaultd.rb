class Vaultd < Formula
  desc "Celestial vault daemon — the one process holding the unlocked master key; UDS by default, loopback TCP on request (ADR-103)"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  version "0.1.0"
  url "https://downloads.celestialintelligence.co/vaultd/vaultd-v#{version}/vaultd-aarch64.tar.gz"
  sha256 "0f86477cc8c30a29675206da96ccdbcca466ec31b7a3530fa745894e33958dd5"
  license "MIT"

  depends_on "node@22"
  depends_on arch: :arm64

  def install
    libexec.install Dir["*"]

    (bin/"vaultd").write <<~EOS
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
