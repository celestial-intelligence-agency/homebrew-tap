class LensCli < Formula
  desc "Web-component-first design-system gallery (@celestial/lens-cli)"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  version "0.1.0"
  license "MIT"

  on_arm do
    url "https://downloads.celestialintelligence.co/lens-cli/lens-v#{version}/lens-cli-aarch64.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  end

  on_intel do
    url "https://downloads.celestialintelligence.co/lens-cli/lens-v#{version}/lens-cli-x86_64.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  end

  depends_on "node@22"

  def install
    # Tarball contains a pnpm-deployed @celestial/lens-cli with its
    # per-arch resolved node_modules (built on the matching macOS runner
    # per build-lens-cli.yml). Brew has already extracted it; move
    # everything into libexec and write a thin bash wrapper in bin/.
    libexec.install Dir["*"]

    (bin/"lens").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@22"].opt_bin}:$PATH"
      cd "#{libexec}"
      exec node bin/lens.mjs "$@"
    EOS
  end

  test do
    # `lens` with no args prints usage and exits 0.
    assert_match "design-system gallery", shell_output("#{bin}/lens")
  end
end
