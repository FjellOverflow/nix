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

    dconf.settings."org/gnome/desktop/app-folders" = {
      folder-children = [ "Disk" "Media" "Office" "Settings" "Sync" "System" "Utilities" ];
    };

    dconf.settings."org/gnome/desktop/app-folders/folders/Disk" = {
      name = "Disk";
      apps = [
        "org.gnome.baobab.desktop"
        "org.gnome.DiskUtility.desktop"
        "gparted.desktop"
      ];
    };

    dconf.settings."org/gnome/desktop/app-folders/folders/Media" = {
      name = "Media";
      apps = [
        "org.gnome.Decibels.desktop"
        "org.gnome.Loupe.desktop"
        "org.gnome.Showtime.desktop"
        "org.videolan.VLC.desktop"
      ];
    };

    dconf.settings."org/gnome/desktop/app-folders/folders/Office" = {
      name = "Office";
      apps = [
        "org.libreoffice.LibreOffice.desktop"
        "org.libreoffice.LibreOffice.Base.desktop"
        "org.libreoffice.LibreOffice.Calc.desktop"
        "org.libreoffice.LibreOffice.Draw.desktop"
        "org.libreoffice.LibreOffice.Impress.desktop"
        "org.libreoffice.LibreOffice.Math.desktop"
        "org.libreoffice.LibreOffice.Writer.desktop"
      ];
    };

    dconf.settings."org/gnome/desktop/app-folders/folders/Settings" = {
      name = "Settings";
      apps = [
        "com.mattjakeman.ExtensionManager.desktop"
        "org.gnome.Extensions.desktop"
        "org.gnome.Settings.desktop"
        "org.gnome.tweaks.desktop"
      ];
    };

    dconf.settings."org/gnome/desktop/app-folders/folders/Sync" = {
      name = "Sync";
      apps = [
        "org.freefilesync.FreeFileSync.desktop"
        "syncthing-gtk.desktop"
      ];
    };

    dconf.settings."org/gnome/desktop/app-folders/folders/System" = {
      name = "System";
      apps = [
        "org.gnome.Connections.desktop"
        "org.gnome.font-viewer.desktop"
        "org.gnome.Logs.desktop"
        "org.gnome.SystemMonitor.desktop"
      ];
    };

    dconf.settings."org/gnome/desktop/app-folders/folders/Utilities" = {
      name = "Utilities";
      apps = [
        "org.gnome.Calculator.desktop"
        "org.gnome.Snapshot.desktop"
        "org.gnome.TextEditor.desktop"
        "org.gnome.Papers.desktop"
      ];
    };
  };
}
