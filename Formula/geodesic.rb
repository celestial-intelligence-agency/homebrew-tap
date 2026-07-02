class Geodesic < Formula
  desc "Agent-facing CLI for the Geodesic workspace API (`geodesic` and `geo` alias)"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  url "https://downloads.celestialintelligence.co/geodesic/geodesic-v0.1.0/geodesic-aarch64.tar.gz"
  version "0.1.0"
  sha256 "d7ee46be02d82d26d56c1e294f6d4ec4ddda39ecaada7254118a0910f829e138"
  license "MIT"

  depends_on "node@22"
  depends_on arch: :arm64

  def install
    libexec.install Dir["*"]

    (bin/"geodesic").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@22"].opt_bin}:$PATH"
      exec node "#{libexec}/dist/cli.js" "$@"
    EOS

    # `geo` is the short alias (matches `sf`, `ss` pattern).
    bin.install_symlink "geodesic" => "geo"
  end

  test do
    assert_match "geodesic", shell_output("#{bin}/geodesic --help 2>&1", 0).downcase
  end
end
