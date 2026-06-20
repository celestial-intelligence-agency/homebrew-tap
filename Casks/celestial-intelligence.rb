cask "celestial-intelligence" do
  version "0.1.0"
  sha256 "21115e016bdf887346b7b6fa29f6a982968332fa3a37bfd3626b0c38c7ded0fb"

  url "https://downloads.celestialintelligence.co/celestial-desktop/desktop-v#{version}/celestial-intelligence-aarch64.dmg"
  name "Celestial Intelligence"
  desc "Operational console for the Celestial Intelligence platform"
  homepage "https://celestialintelligence.co/"

  depends_on arch: :arm64
  depends_on :macos

  app "Celestial Intelligence.app"

  zap trash: [
    "~/Library/Application Support/co.celestialintelligence.desktop",
    "~/Library/Preferences/co.celestialintelligence.desktop.plist",
    "~/Library/Saved Application State/co.celestialintelligence.desktop.savedState",
  ]

  caveats <<~EOS
    This build is ad-hoc signed (no Apple Developer ID yet).
    If macOS shows "Celestial Intelligence.app is damaged and can't be opened",
    run:
      xattr -cr "/Applications/Celestial Intelligence.app"
    Or install with: brew install --cask celestial-intelligence --no-quarantine
  EOS
end
