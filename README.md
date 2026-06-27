# nixconf

Personal NixOS flake configuration for **atsada-pc** (AMD CPU, dual NVMe btrfs RAID, dual monitors, Niri compositor).

Built with [flake-parts](https://github.com/hercules-ci/flake-parts) + [wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules). Dracula theme throughout.

## Structure

```
flake.nix            -- inputs + auto-import of all .nix files
parts.nix            -- flake-parts system + wrapper-modules setup
theme.nix            -- Dracula base16 palette (self.theme / self.themeNoHash)
nixos/
  base/              -- preference options (user, keymap, monitors, autostart)
  features/          -- general, network, desktop, gaming, dev, nix, gtk, brave, pipewire
  hosts/main/        -- host config, hardware, disko partitioning
wrapped/
  niri.nix           -- niri compositor wrapper (keybindings, workspaces, window rules)
  kitty.nix          -- kitty terminal wrapper (colors, fonts, tabs)
  fish.nix           -- fish shell wrapper (direnv, zoxide, vi mode)
  git.nix            -- git wrapper (name, email, lfs)
  environment.nix    -- fish shell env + runtime packages + desktop/terminal wrappers
  neovim/            -- neovim wrapper + lua config (init.lua, after/plugin/)
  noctalia/          -- noctalia-shell wrapper (bar, launcher, colors)
```

Every `.nix` file (except `flake.nix`) is auto-imported by flake-parts. Files prefixed with `_` are excluded.

## Clean Install

### 1. Boot NixOS live USB

Download from https://nixos.org/download/ and boot the installer.

### 2. Partition disks with disko

```bash
sudo nix --extra-experimental-features 'nix-command flakes' \
  run github:nix-community/disko -- \
  --mode destroy,format,mount \
  --flake github:Plaikrub/nixconf#hostMain
```

This creates:
- ESP partition (1G, vfat) -> /boot
- Swap partition (16G)
- btrfs RAID0 data + RAID1 metadata across both NVMes -> /, /home, /nix

### 3. Install NixOS

```bash
sudo nixos-install --flake github:Plaikrub/nixconf#main --no-channel-copy --no-root-password
```

### 4. Post-install

```bash
# Reboot
sudo reboot

# Login with initial password, then CHANGE IT IMMEDIATELY
passwd

# Clone repo to the path neovimDynamic expects
git clone https://github.com/Plaikrub/nixconf ~/.local/nixconf
```

## Updating

### Update system

```bash
sudo nixos-rebuild switch --flake ~/.local/nixconf#main
```

### Update flake inputs

```bash
# Update all inputs to latest
nix flake update

# Update a specific input
nix flake update nixpkgs
nix flake update flake-parts

# Verify before applying
nix flake check --no-build
```

### Rollback

```bash
# List previous generations
nix-env --list-generations --profile /nix/var/nix/profiles/system

# Roll back to previous generation
sudo nixos-rebuild switch --rollback
```

### Garbage collection

```bash
# Delete generations older than 7 days
sudo nix-collect-garbage --delete-older-than 7d

# Aggressive cleanup (keep only current)
sudo nix-collect-garbage -d
```

## Verify

```bash
# Evaluate the flake without building (fast sanity check)
nix flake check --no-build
```

Warnings about `diskoConfigurations`, `wrappers`, `wrapperModules`, `theme`, `themeNoHash` are expected — these are custom flake outputs.