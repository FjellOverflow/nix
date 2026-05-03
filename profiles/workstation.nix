{ config, pkgs, user, ... }:

{
  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };
  services.xserver.excludePackages = with pkgs; [ xterm ];

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = false;

  console.keyMap = "no";

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.mullvad-vpn.enable = true;
  services.syncthing = {
    enable = true;
    user = user;
    dataDir = "/home/${user}/Syncthing";
  };

  documentation.nixos.enable = false;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  environment.systemPackages = with pkgs; [
    baobab
    decibels
    deja-dup
    gnome-boxes
    gnome-calculator
    gnome-connections
    gnome-disk-utility
    gnome-font-viewer
    gnome-logs
    gnome-system-monitor
    gnome-text-editor
    gnome-tweaks
    gparted
    loupe
    mullvad-vpn
    nautilus
    papers
    ptyxis
    showtime
    snapshot
    syncthing
    vscode
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "com.bitwarden.desktop"
      "com.brave.Browser"
      "com.mattjakeman.ExtensionManager"
      "com.spotify.Client"
      "com.usebruno.Bruno"
      "md.obsidian.Obsidian"
      "org.freefilesync.FreeFileSync"
      "org.gimp.GIMP"
      "org.inkscape.Inkscape"
      "org.libreoffice.LibreOffice"
      "org.videolan.VLC"
    ];
  };

  home-manager.users.${user} = { ... }: {
    dconf.settings."org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Ptyxis.desktop"
        "com.brave.Browser.desktop"
        "code.desktop"
        "org.gnome.Nautilus.desktop"
        "md.obsidian.Obsidian.desktop"
      ];
    };
  };
}
