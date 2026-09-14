class Geodesic < Formula
  desc "Agent-facing CLI for the Geodesic workspace API (`geodesic` and `geo` alias)"
  homepage "https://github.com/celestial-intelligence-agency/geodesic"
  version "0.3.0"
  url "https://downloads.celestialintelligence.co/geodesic/geodesic-v#{version}/geodesic-aarch64.tar.gz"
  sha256 "4b20d31e2d9d6a6e9ee322476fda87b16be6f32699c3fe3e11b51e0d8f08409f"
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
