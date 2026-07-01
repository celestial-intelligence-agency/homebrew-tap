cask "attache" do
  version "0.1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/dasysad/attache/releases/download/desktop-v#{version}/attache-desktop-aarch64-desktop-v#{version}.dmg"
  name "Attache"
  desc "Local-first household finance attache"
  homepage "https://github.com/dasysad/attache"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Attache.app"

  zap trash: [
    "~/Library/Application Support/com.attache.desktop",
    "~/Library/Preferences/com.attache.desktop.plist",
    "~/Library/Saved Application State/com.attache.desktop.savedState",
  ]

  caveats <<~EOS
    This build is ad-hoc signed (no Apple Developer ID yet).
    If macOS shows "Attache.app is damaged and can't be opened", run:
      xattr -cr "/Applications/Attache.app"
    Or install with: brew install --cask attache --no-quarantine

    The pinned sha256 is updated automatically after each desktop-v* release.
    Until the first release is published, `brew install --cask attache` will fail checksum verification.
  EOS
end
