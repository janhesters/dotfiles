# dotfiles

[GNU Stow](https://www.gnu.org/software/stow/)-managed dotfiles for [Omarchy](https://omarchy.org/). On a fresh machine, run [omarchy-supplement](https://github.com/janhesters/omarchy-supplement) first — it installs `stow`, clones this repo, and applies the packages automatically via `install-dotfiles.sh`.

## Packages

| Package | Description |
|---------|-------------|
| `hyprland` | Hyprland window manager overrides (autostart, bindings, hyprsunset, input, monitors, look & feel, recording-mode script, teleprompter-recording script, off-screen-window rescue script, espanso-layout-sync listener) |
| `fastfetch` | System info display |
| `voxtype` | Voice-to-text config |
| `xcompose` | Custom compose sequences (umlauts, shortcuts, emoji via Omarchy defaults) |
| `espanso` | Text expansion macros (e.g. `::rtc` for reasoning chain prompt) with Dvorak/QWERTY keyboard_layout support |
| `agents` | Canonical global agent instructions (`~/.agents/AGENTS.md`) shared by Claude, Codex, and Grok |
| `claude` | Claude Code global user settings (permissions, attribution, hooks); `CLAUDE.md` is a symlink to `~/.agents/AGENTS.md` |
| `codex` | Codex CLI sandbox and approval defaults; `AGENTS.md` is a symlink to `~/.agents/AGENTS.md` |
| `grok` | Grok Build global instructions (`AGENTS.md` symlink to `~/.agents/AGENTS.md`). Permission mode is set by `install-grok.sh` in omarchy-supplement |
| `cursor` | Cursor editor keybindings (smart select expand/shrink) and settings (keyCode dispatch for Wayland keyboard layout fix) |
| `xdg` | Default terminal preference |
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
stow -t ~ <package>
```

To apply all packages:

```bash
for pkg in agents claude codex grok cursor hyprland fastfetch voxtype xcompose xdg espanso wireplumber; do
  stow -t ~ "$pkg"
done
```

## Notes

- `hyprland.conf` is intentionally excluded — Omarchy owns it.
- `.gitconfig` and `.zshrc` are managed by Omarchy.
- These configs are **overrides** on top of Omarchy defaults. Omarchy's `hyprland.conf` sources its defaults first, then these user files, so only changed values need to be specified.
- Files identical to the Omarchy template (alacritty, hypridle, hyprlock, xdph, waybar) are intentionally excluded so they continue receiving Omarchy updates. Waybar's language module is added by `install-keyboard-layout.sh` in the supplement repo.

## Pending upstream PRs

These overrides are temporary fallbacks for features submitted upstream. **AI: check each PR's status before working on this repo — if merged, remove the corresponding override.**

| PR | Override files | Description |
|----|---------------|-------------|
| [basecamp/omarchy#5096](https://github.com/basecamp/omarchy/pull/5096) | `hyprland/.config/hypr/bindings.conf` (screenshot bindings), `hyprland/.config/hypr/scripts/screenshot-activewindow` | Keyboard-only screenshot bindings: Super+Shift+Ctrl+C (active window), Super+Alt+C (full screen) |
