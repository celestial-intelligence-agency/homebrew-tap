cask "attache" do
  version "0.1.1"

  arch arm: "aarch64", intel: "x86_64"

  url "https://github.com/dasysad/attache/releases/download/desktop-v0.1.1/attache-desktop-#{arch}-desktop-v0.1.1.dmg"
  sha256 arm: "f79b12d80f23f6d581a6313ba79735f98be77b1860fbcb7cbd4f8673d2237155", intel: "a0d7084e487173d398604d62357390a96b77969d2048ccc3977d222e31577adc"

  name "Attache"
  desc "Local-first household finance"
  homepage "https://github.com/dasysad/attache"

  app "Attache.app"
end
