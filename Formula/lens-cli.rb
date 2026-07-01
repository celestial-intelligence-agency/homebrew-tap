class LensCli < Formula
  desc "Web-component-first design-system gallery (@celestial/lens-cli)"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  url "https://downloads.celestialintelligence.co/lens-cli/lens-v0.1.0/lens-cli-aarch64.tar.gz"
  version "0.1.0"
  sha256 "3aa52ee9b909e258725820212f2ee012979e1e6d0d0b70dc40e994df63ecac60"
  license "MIT"

  depends_on "node@22"
  depends_on arch: :arm64

  def install
    # Tarball contains a pnpm-deployed @celestial/lens-cli with its
    # arm64-resolved node_modules (built on macos-latest per
    # build-lens-cli.yml). Brew has already extracted it; move everything
    # into libexec and write a thin bash wrapper in bin/.
    libexec.install Dir["*"]

    # Do NOT cd into libexec before exec — lens.mjs reads process.cwd()
    # at startup to locate lens.config.ts / lens.theme.css / stories/.
    # Invoke node with the absolute path so cwd stays as the user's dir.
    # Node still resolves node_modules via lens.mjs's script location.
    (bin/"lens").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@22"].opt_bin}:$PATH"
      exec node "#{libexec}/bin/lens.mjs" "$@"
    EOS
  end

  test do
    # `lens` with no args prints usage and exits 0.
    assert_match "design-system gallery", shell_output("#{bin}/lens")
  end
end
