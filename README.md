# NixOS Config

## Initial setup

```bash
nix-shell -p git
git clone https://github.com/FjellOverflow/nix.git ~/nix && cd ~/nix

mkdir machines/<hostname>
sudo cp /etc/nixos/hardware-configuration.nix machines/<hostname>/hardware-configuration.nix
sudo chown $(whoami): machines/<hostname>/hardware-configuration.nix

# create machines/<hostname>/default.nix (see existing machines/ for reference)

sudo rm -rf /etc/nixos
sudo ln -s ~/nix /etc/nixos

sudo nixos-rebuild switch --flake /etc/nixos#<hostname>
```

## Apply latest config

```bash
git pull && nh os switch
```

## Cleanup

```bash
nh clean all
```
