class Geodesic < Formula
  desc "Agent-facing CLI for the Geodesic workspace API (`geodesic` and `geo` alias)"
  homepage "https://github.com/celestial-intelligence-agency/geodesic"
  version "0.3.1"
  url "https://downloads.celestialintelligence.co/geodesic/geodesic-v#{version}/geodesic-aarch64.tar.gz"
  sha256 "f40e089b7745d45c9f8bcbd5c33ec471bf4c2da44367b1b078c6ffb6d2af76b8"
  license "AGPL-3.0-only"

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
