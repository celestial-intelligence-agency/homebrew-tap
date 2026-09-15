class Geodesic < Formula
  desc "Agent-facing CLI for the Geodesic workspace API (`geodesic` and `geo` alias)"
  homepage "https://github.com/celestial-intelligence-agency/geodesic"
  version "0.3.3"
  url "https://downloads.celestialintelligence.co/geodesic/geodesic-v#{version}/geodesic-aarch64.tar.gz"
  sha256 "16de75047a89e06860befd144ec96a5eaa6d44879e812bd4c1b73b886ed58871"
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

  # GEO-004: equivalent to `geodesic serve --install-agent`. Use one
  # supervisor only — this, the LaunchAgent, or celestiald/orbit.
  service do
    run [opt_bin/"geodesic", "serve"]
    keep_alive true
    process_type :background
    working_dir var
    log_path var/"log/geodesic.log"
    error_log_path var/"log/geodesic.log"
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:#{Formula["node@22"].opt_bin}:/usr/bin:/bin"
  end

  test do
    assert_match "geodesic", shell_output("#{bin}/geodesic --help 2>&1", 0).downcase
  end
end
