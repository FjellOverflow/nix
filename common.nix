{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Oslo";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.fjelloverflow = {
    isNormalUser = true;
    description = "FjellOverflow";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  nixpkgs.config.allowUnfree = true;

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

  programs.fish = {
    enable = true;
    shellAliases = {
      cat = "bat";
    };
    interactiveShellInit = ''
      set fish_greeting
    '';
  };

  programs.starship = {
    enable = true;
  };

  users.users.fjelloverflow.shell = pkgs.fish;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";

  security.sudo.wheelNeedsPassword = false;
}
