class StarsystemCli < Formula
  desc "Starsystem infrastructure control-plane CLI — `ss` (and `starsystem` alias)"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  version "0.2.0"
  url "https://downloads.celestialintelligence.co/starsystem-cli/ss-v#{version}/starsystem-cli-aarch64.tar.gz"
  sha256 "2a1bc89046dc4088f3b7ff593fa56ed2e5784ca6da1a9c9c1682d1b4ea7af43f"
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
