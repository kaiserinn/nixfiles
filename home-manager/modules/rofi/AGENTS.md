# AGENTS.md – rofi Home Manager module

This dir is a Home Manager symlink module, not upstream rofi development.

## Layout

- `default.nix` symlinks `rofi/` to `~/.config/rofi` via `mkOutOfStoreSymlink`. Edits apply live, no `home-manager switch` needed for config/theme tweaks.
- `rofi/config.rasi` is the live config.
- `rofi/themes/default.rasi` is the default theme. Don't edit this.
- `rofi/default.rasi` is the default config. Don't edit this.
- `rofi/my-old-config/` is my old config, only for backup. Leave untouched unless asked. Don't use this as a reference for anything unless asked to.
- Only edit `rofi/` + `default.nix`. Never edit `rofi-repo/`.

## Upstream source of truth

`rofi-repo/` is a vendored copy of `davatorium/rofi`, read-only. Consult it before guessing syntax:

- `rofi-repo/Examples/` – script/dmenu/combi usage patterns.
- `rofi-repo/themes/` – bundled themes to `@theme` by bare name (e.g. `@theme "gruvbox-light"`).
- `rofi-repo/CONFIG.md` – config file location, format, `@import`/`@theme` split-file order.
- `rofi-repo/doc/rofi.1.markdown`, `rofi-theme.5.markdown`, `rofi-script.5.markdown`, `rofi-dmenu.5.markdown` – authoritative over wiki/README; match docs to installed rofi version.
- `rofi-repo/doc/default_configuration.rasi`, `doc/default_theme.rasi` – defaults.

## Stack: NixOS + Home Manager + Niri (Wayland)

- Rofi auto-selects Wayland backend under Niri. Force X11 only for debugging: `rofi -x11 …`.
- On Wayland these are missing/partial per upstream `README.md`: `-normal-window`, `-monitor -n`, `x-offset`/`y-offset` (edge-only), fake transparency. Prefer `drun`/`run`; verify `window` mode on Niri before relying on it.
- Test only inside a Niri Wayland session; headless/SSH cannot render rofi.

## rasi gotchas

- File is `configuration { … }` plus trailing `@theme`/`@import`. Parse order: `config.rasi` block, then imports, then theme. Theme overrides go after the `@theme` line.
- `@theme "name"` resolves against `~/.config/rofi/themes/` + bundled themes. Avoid absolute `/home/azhar/…` paths like the commented line in `config.rasi:13` – they break portability.
- Encoding UTF-8, `//` and `/* */` comments, whitespace-insensitive. Strings always `"quoted"`, booleans `true`/`false` lowercase.

## Verify

- `rofi -dump-config > rofi/tmp/rofi-config.rasi` – parse-check config.
- `rofi -dump-theme > rofi/tmp/rofi-theme.rasi` – parse-check resolved theme.
- `rofi -show drun` – smoke test in Niri.
- `rofi-theme-selector` – interactive theme preview.
