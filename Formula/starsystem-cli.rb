class StarsystemCli < Formula
  desc "Starsystem infrastructure control-plane CLI — `ss` (and `starsystem` alias)"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  version "0.2.6"
  url "https://downloads.celestialintelligence.co/starsystem-cli/ss-v#{version}/starsystem-cli-aarch64.tar.gz"
  sha256 "8cd5810664dbc0490a0a99cdbb89e2df74eed050e48ddb1c0b24192a8f5cbae8"
  license "MIT"

  depends_on "node@22"
  depends_on arch: :arm64

  def install
    libexec.install Dir["*"]

    (bin/"ss").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@22"].opt_bin}:$PATH"
      exec node "#{libexec}/dist/cli.js" "$@"
    EOS

    bin.install_symlink "ss" => "starsystem"
  end

  test do
    assert_match "starsystem", shell_output("#{bin}/ss --help 2>&1", 0).downcase
  end
end
