class Geodesic < Formula
  desc "Agent-facing CLI for the Geodesic workspace API (`geodesic` and `geo` alias)"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  version "0.2.0"
  url "https://downloads.celestialintelligence.co/geodesic/geodesic-v#{version}/geodesic-aarch64.tar.gz"
  sha256 "8b3e40c5d776f3b4c7c25d40edd5d4904062602e6b76a49686770ff964c356a8"
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
