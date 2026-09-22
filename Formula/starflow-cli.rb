class StarflowCli < Formula
  desc "Starflow durable workflows — `sf` (and `starflow` alias)"
  homepage "https://github.com/celestial-intelligence-agency/starflow"
  version "0.1.7"
  url "https://downloads.celestialintelligence.co/starflow-cli/sf-v#{version}/starflow-cli-aarch64.tar.gz"
  sha256 "5670144e350a15d6a4403640b91ae0b943836f249fef9507a852c1007d77cf0d"
  license "AGPL-3.0-only"

  depends_on "node@24"
  depends_on arch: :arm64

  def install
    # The tarball is `pnpm deploy --prod` of @celestial/starflow-cli
    # (scripts/release-brew.mjs in the starflow repository): dist/ plus
    # production node_modules. Brew has already extracted it; move it into
    # libexec and write thin wrappers in bin/.
    #
    # Do not `cd` into libexec before exec: commands read starflow.yaml and
    # resolve paths from the user's working directory. Node finds
    # node_modules from dist/cli.js's own location.
    libexec.install Dir["*"]

    (bin/"sf").write <<~EOS
      #!/bin/bash
      export PATH="#{Formula["node@24"].opt_bin}:$PATH"
      exec node "#{libexec}/dist/cli.js" "$@"
    EOS

    # `starflow` is the long-form alias of `sf`.
    bin.install_symlink "sf" => "starflow"
  end

  test do
    (testpath/"starflow.yaml").write <<~YAML
      name: brew-test
      pipelines:
        hello:
          triggers: [{ type: manual }]
          steps:
            greet:
              run: echo hello
    YAML
    assert_match "starflow", shell_output("#{bin}/sf --help 2>&1", 0).downcase
    assert_match "Valid starflow config", shell_output("#{bin}/sf validate 2>&1")
  end
end
