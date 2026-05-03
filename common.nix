{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  system.stateVersion = "25.11";
  security.sudo.wheelNeedsPassword = false;

  users.users.fjelloverflow = {
    isNormalUser = true;
    description = "FjellOverflow";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    bat
    curl
    git
    nano
    ncdu
    tmux
    tree
    wget
  ];

  programs.fish.enable = true;

  services.tailscale.enable = true;
  virtualisation.docker.enable = true;

  home-manager.users.fjelloverflow = { pkgs, ... }: {
    home.stateVersion = "25.11";

    programs.fish = {
      enable = true;
      shellAliases = {
        cat = "bat";
      };
      interactiveShellInit = ''
        set fish_greeting
      '';
    };

    programs.starship.enable = true;
  };
}
