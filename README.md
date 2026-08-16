# dotfiles

[GNU Stow](https://www.gnu.org/software/stow/)-managed dotfiles for [Omarchy](https://omarchy.org/). On a fresh machine, run [omarchy-supplement](https://github.com/janhesters/omarchy-supplement) first — it installs `stow`, clones this repo, and applies the packages automatically via `install-dotfiles.sh`.

## Packages

| Package | Description |
|---------|-------------|
| `hyprland` | Hyprland window manager overrides (Quattro Lua monitor, input, hotkey, and autostart config; recording, teleprompter, off-screen-window, and Espanso layout-sync helpers) |
| `fastfetch` | System info display |
| `voxtype` | Voice-to-text config |
| `xcompose` | Custom compose sequences (umlauts, shortcuts, emoji via Omarchy defaults) |
| `espanso` | Text expansion macros (e.g. `::rtc` for reasoning chain prompt) with immutable Dvorak/QWERTY profiles selected at runtime by the Hyprland layout-sync helper |
| `agents` | Canonical global agent instructions (`~/.agents/AGENTS.md`) shared by Claude, Codex, and Grok |
| `claude` | Claude Code global user settings and Omarchy notification hook; `CLAUDE.md` is a symlink to `~/.agents/AGENTS.md` |
| `codex` | Codex CLI model, sandbox, approval, status-line, and desktop-notification settings; `AGENTS.md` is a symlink to `~/.agents/AGENTS.md` |
| `grok` | Grok Build global instructions (`AGENTS.md` symlink to `~/.agents/AGENTS.md`). Permission mode is set by `install-grok.sh` in omarchy-supplement |
| `cursor` | Cursor editor keybindings (smart select expand/shrink) and settings (keyCode dispatch for Wayland keyboard layout fix) |
| `wireplumber` | PipeWire session manager rules (demote Sony ZV-E1 camera audio so real mics always win default-source selection) |

### Global agent instructions

One file owns the system-wide agent brief: `agents/.agents/AGENTS.md` → stowed as `~/.agents/AGENTS.md`.

Tool-facing names are symlinks into that file (relative targets that resolve after stow):

- `~/.claude/CLAUDE.md` → `../.agents/AGENTS.md`
- `~/.codex/AGENTS.md` → `../.agents/AGENTS.md`
- `~/.grok/AGENTS.md` → `../.agents/AGENTS.md`

Stow **`agents` before** `claude` / `codex` / `grok` so the real file exists when the links are created. Edit only `agents/.agents/AGENTS.md` (or `~/.agents/AGENTS.md` after stow).

## Usage

```bash
cd ~/dev/dotfiles
stow --no-folding --target "$HOME" <package>
```

To apply all packages:

```bash
for pkg in agents claude codex grok cursor hyprland fastfetch voxtype xcompose espanso wireplumber; do
  stow --no-folding --target "$HOME" "$pkg"
done
```

For an existing Omarchy installation, prefer `install-dotfiles.sh` from
[`omarchy-supplement`](https://github.com/janhesters/omarchy-supplement). It
backs up conflicting files, unfolds older Stow trees, creates Espanso's runtime
profile selector, and reloads the desktop safely. On a clean manual install,
initialize Espanso and start the listener for the current session after stowing:

```bash
espanso service check >/dev/null 2>&1 || espanso service register
~/.config/hypr/scripts/espanso-layout-sync --once
if ! espanso service status >/dev/null 2>&1; then
  espanso service start
  ~/.config/hypr/scripts/espanso-layout-sync --once
fi
uwsm-app -- ~/.config/hypr/scripts/espanso-layout-sync
```

The listener also starts automatically at the next Hyprland login.

## Notes

- `hyprland.lua` is intentionally excluded — Omarchy owns the entry point.
- `.gitconfig` and `.zshrc` are managed by Omarchy.
- Default applications are shared state managed by the supplement through `omarchy default`, not Stow symlinks.
- These Lua modules are **overrides** loaded after Omarchy's Quattro defaults, so they contain only personal changes.
- Files identical to the Omarchy template are intentionally excluded so they continue receiving Omarchy updates. The supplement adds the keyboard-layout widget to the Quattro shell bar.
- `~/.config/espanso/config/default.yml` is intentionally runtime state rather than a tracked file. `install-dotfiles.sh` uses `stow --no-folding`, and the layout-sync helper atomically points it at the active profile without modifying the repository.
