# Celestial Intelligence — Homebrew tap

Homebrew tap for the Celestial family of desktop apps and CLIs — Celestial Intelligence, Attache, and (soon) lens / geodesic.

## Install

```sh
brew tap celestial-intelligence-agency/tap

brew install --cask celestial-intelligence   # Operational console desktop
brew install --cask attache                  # Household finance desktop
brew install attache-cli                     # Household finance CLI
```

## Available

| Name | Type | Description |
|---|---|---|
| `celestial-intelligence` | Cask | Operational console desktop app (Apple Silicon) |
| `attache` | Cask | Local-first household finance desktop app (Apple Silicon) |
| `attache-cli` | Formula | Household finance CLI (`attache` command) |

Planned: `lens-cli`, `geodesic` (also installs `geo`).

## Notes

Builds are currently ad-hoc signed (no Apple Developer ID yet). If macOS reports an app is damaged:

```sh
xattr -cr "/Applications/Celestial Intelligence.app"
xattr -cr "/Applications/Attache.app"
# or install with:
brew install --cask <name> --no-quarantine
```

## Updates

Casks and formulas are auto-bumped from their upstream repos on release:

- `celestial-intelligence` cask — bumped from [celestial-orchestration](https://github.com/celestial-intelligence-agency/celestial-orchestration) on each `desktop-v*` release.
- `attache` cask — bumped from [attache](https://github.com/dasysad/attache) on each `desktop-v*` release.
- `attache-cli` formula — manually bumped on `v*` tags for now.
