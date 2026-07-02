class StarflowCli < Formula
  desc "Starflow orchestrator CLI — `sf` (and `starflow` alias)"
  homepage "https://github.com/celestial-intelligence-agency/celestial-orchestration"
  url "https://downloads.celestialintelligence.co/starflow-cli/sf-v0.1.0/starflow-cli-aarch64.tar.gz"
  version "0.1.0"
  sha256 "ab4295589681a29fa9a9d2dac7b045f71b95855ed1427895122cf61a910d5b7c"
  license "MIT"

  depends_on "node@22"
  depends_on arch: :arm64

  def install
    # Tarball contains a pnpm-deployed @celestial/starflow-cli with its
    # arm64-resolved node_modules (built on macos-latest per
    # build-starflow-cli.yml). Brew has already extracted it; move
    # everything into libexec and write thin bash wrappers in bin/.
    #
    # Do NOT `cd` into libexec before exec — some subcommands rely on
    # process.cwd() being the user's project dir (starflow.yaml lookup,
    # relative worktree paths, …). Invoke node with the absolute path
    # so cwd stays as the user's dir; Node resolves node_modules via
    # dist/cli.js's script location.
    libexec.install Dir["*"]

    (bin/"sf").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@22"].opt_bin}:$PATH"
      exec node "#{libexec}/dist/cli.js" "$@"
    EOS

    # `starflow` is the long-form alias of `sf` — same binary, same behavior.
    bin.install_symlink "sf" => "starflow"
  end

  test do
    # `sf` with no args prints usage and exits with non-zero (per convention);
    # match on the header so we know we invoked correctly.
    assert_match "starflow", shell_output("#{bin}/sf --help 2>&1", 0).downcase
  end
end
