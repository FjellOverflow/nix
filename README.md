<h1 align="center">
  <a href="https://github.com/FjellOverflow/nix">nix</a>
</h1>

<p align="center">
  My personal NixOS configuration
</p>

<p align="center">
  <img src="https://img.shields.io/badge/NixOS-26.05-5277C3?logo=nixos&logoColor=white"/>
  &ensp;
  <img src="https://img.shields.io/badge/Flakes-enabled-5277C3?logo=nixos&logoColor=white"/>
  &ensp;
  <img src="https://img.shields.io/badge/Home_Manager-integrated-5277C3?logo=nixos&logoColor=white"/>
  &ensp;
  <img src="https://img.shields.io/github/actions/workflow/status/FjellOverflow/nix/ci.yaml?branch=main&label=CI"/>
</p>

> [!WARNING]
> This repository is no longer updated or maintained, as all its functionality it is now a part of [FjellOverflow/nisse](https://github.com/FjellOverflow/nisse).

<p align="center">
  <a href="#overview">Overview</a> |
  <a href="#structure">Structure</a> |
  <a href="#machines">Machines</a> |
  <a href="#setup">Setup</a> |
  <a href="#usage">Usage</a>
</p>

## Overview

My personal [NixOS](https://nixos.org/) configuration as a [Nix flake](https://nixos.wiki/wiki/Flakes), with [Home Manager](https://github.com/nix-community/home-manager) for dotfiles and software. Includes a common base config and opt-in modules, consumed via machine profiles.

| Flake input                                                                     | Description                  |
| ------------------------------------------------------------------------------- | ---------------------------- |
| [nixpkgs](https://github.com/NixOS/nixpkgs) `26.05`                             | NixOS packages               |
| [home-manager](https://github.com/nix-community/home-manager) `26.05`           | User environment & dotfiles  |
| [nix-flatpak](https://github.com/gmodena/nix-flatpak)                           | Declarative Flatpak installs |
| [nix-vscode-extensions](https://github.com/nix-community/nix-vscode-extensions) | VSCodium extensions          |

## Structure

```
nix/
├── flake.nix                           # Flake definition and inputs
├── common.nix                          # Base config, shared by all machines
├── machines/
│   └── <hostname>/                     # Machine-specific settings
│       ├── default.nix
│       └── hardware-configuration.nix
├── modules/                            # Opt-in features
├── profiles/
│   └── workstation.nix                 # Full desktop
└── assets/
```

## Machines

All machines include `fish` shell, `starship` prompt, `direnv` + `nix-direnv`, `git`, `docker`, `nh`, and a curated set of CLI tools via the shared `common.nix` config.

| Hostname   | Profile     | Type            |
| ---------- | ----------- | --------------- |
| `vm`       | workstation | Virtual machine |
| `thinkpad` | workstation | Laptop          |
| `brick`    | workstation | Desktop         |
| `gigabyte` | workstation | Desktop         |


## Setup

> [!NOTE]
> Requires an fresh/existing NixOS installation.

```bash
nix-shell -p git
git clone https://github.com/FjellOverflow/nix.git ~/nix && cd ~/nix

# Create a machine config
mkdir machines/<hostname>
sudo cp /etc/nixos/configuration.nix machines/<hostname>/default.nix
sudo cp /etc/nixos/hardware-configuration.nix machines/<hostname>/hardware-configuration.nix
sudo chown $(whoami): machines/<hostname>/*

# Adapt machines/<hostname>/default.nix (see existing machines/ for reference)

# Replace /etc/nixos with this repo
sudo rm -rf /etc/nixos
sudo ln -s ~/nix /etc/nixos

# Build and switch
sudo nixos-rebuild switch --flake /etc/nixos#<hostname>
```

## Usage

### Apply the latest config

```bash
git pull && nh os switch
```

### Clean up old generations

```bash
nh clean all
```
