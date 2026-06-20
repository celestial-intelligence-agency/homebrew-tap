# Celestial Intelligence — Homebrew tap

Homebrew tap for Celestial Intelligence desktop apps and CLIs.

## Install

```sh
brew tap celestial-intelligence-agency/tap
brew install --cask celestial-intelligence
```

## Available casks

| Cask | Description |
|---|---|
| `celestial-intelligence` | Operational console desktop app (Apple Silicon) |

## Notes

Builds are currently ad-hoc signed (no Apple Developer ID). If macOS reports the
app is damaged, install with `--no-quarantine` or strip the quarantine attribute:

```sh
xattr -cr "/Applications/Celestial Intelligence.app"
```

## Updates

The `celestial-intelligence` cask is auto-bumped from
[celestial-orchestration](https://github.com/celestial-intelligence-agency/celestial-orchestration)
on each `desktop-v*` release.
