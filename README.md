# nixfiles

_nixfiles—dotfiles but nix._

Clone the repository (`/etc/nixos` is the default configuration path for NixOS).
```bash
jj git clone git@github.com:kaiserinn/nixfiles.git ~/.config/nix
cd ~/.config/nix
```

Rebuild the system.
```bash
sudo nixos-rebuild switch --flake .
```
Or, use [kintsugi](https://github.com/kaiserinn/kintsugi).
```bash
kin construct
```
