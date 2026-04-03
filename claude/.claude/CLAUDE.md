# System-Wide Instructions

## Asking Questions

When unsure about the user's intent, constraints, or the best approach, ask clarifying questions rather than guessing. This applies both before starting work (e.g., before researching, fetching, or writing code) and after gathering information (e.g., when findings are ambiguous or multiple paths are viable). Prefer a short question over a wrong assumption.

## Omarchy

OmarchyPackageManagement {
  Constraints {
    Never use `pacman -S` or `yay -S` directly to install packages.
    Never edit files in `~/.local/share/omarchy/` — always override in `~/.config/`.
    Omarchy wraps package management with its own commands that ensure consistency across updates.
  }

  install(package) => match (package) {
    case (official Arch repo) => `omarchy-pkg-add <package>`
    case (AUR) => `omarchy-pkg-aur-add <package>`
    case (interactive browsing) => `omarchy-pkg-install`
  }

  remove(package) => `omarchy-pkg-drop <package>`

  check(package) => match (intent) {
    case (is it missing?) => `omarchy-pkg-missing <package>`
    case (is it present?) => `omarchy-pkg-present <package>`
  }
}

## Mise

Bun (and potentially other dev tools) are managed via [mise](https://mise.jdx.dev/). To upgrade:
- `mise upgrade bun` — upgrade bun to latest
- `mise install bun@latest && mise use -g bun@latest` — install and set a specific version globally

Do not use `bun upgrade` or system package managers for bun.

## Personal Repos

- **`~/dev/dotfiles`** — GNU Stow packages for config file overrides (`~/.config/hypr/`, `~/.config/espanso/`, etc.). Use for files that can be fully owned by the user and symlinked into `~/.config/`. Not suitable for shared files like `mimeapps.list` that other tools also write to.
- **`~/dev/omarchy-supplement`** — Idempotent install scripts for post-Omarchy setup (packages, key remapping, default apps, web apps, themes, etc.). Use for imperative actions like `xdg-mime default`, package installs, or anything that modifies shared system state.
