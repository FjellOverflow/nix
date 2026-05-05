{ config, pkgs, user, ... }:

{
  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.xserver.excludePackages = with pkgs; [ xterm ];

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = false;

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
    brave
    decibels
    deja-dup
    gnome-boxes
    gnome-shell-extensions
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

  environment.etc."brave/policies/managed/policy.json".text = builtins.toJSON {
    # Brave features
    BraveRewardsDisabled = true;
    BraveWalletDisabled = true;
    BraveVPNDisabled = true;
    BraveAIChatEnabled = false;
    BraveP3AEnabled = false;
    BraveStatsPingEnabled = false;
    BraveWebDiscoveryEnabled = false;
    BraveNewsDisabled = true;
    BraveTalkDisabled = true;
    BraveSpeedreaderEnabled = false;
    BraveWaybackMachineEnabled = false;
    BravePlaylistEnabled = false;
    SyncDisabled = true;
    # Chromium
    PromotionalTabsEnabled = false;
    MetricsReportingEnabled = false;
    BackgroundModeEnabled = false;
    PasswordManagerEnabled = false;
    AutofillAddressEnabled = false;
    AutofillCreditCardEnabled = false;
    TranslateEnabled = false;
    SpellCheckServiceEnabled = false;
    SearchSuggestEnabled = false;
    NetworkPredictionOptions = 2;
    DefaultBrowserSettingEnabled = false;
    DefaultSearchProviderEnabled = true;
    DefaultSearchProviderName = "DuckDuckGo";
    DefaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
    DefaultSearchProviderSuggestURL = "https://duckduckgo.com/ac/?q={searchTerms}&type=list";
    UserFeedbackAllowed = false;
    SafeBrowsingExtendedReportingEnabled = false;
    ImportBrowserSettings = false;
    DnsOverHttpsMode = "secure";
    DnsOverHttpsTemplates = "https://dns.adguard-dns.com/dns-query";
    # Extensions
    ExtensionInstallForcelist = [
      "nngceckbapebfimnlniiiahkandclblb;https://clients2.google.com/service/update2/crx"
      "aapbdbdomjkkjkaonfhkkikfgjllcleb;https://clients2.google.com/service/update2/crx"
    ];
  };

  home-manager.users.${user} = { ... }: {
    dconf.settings."org/gnome/Ptyxis" = {
      audible-bell = false;
      visual-bell = false;
      use-system-font = false;
      font-name = "FiraCode Nerd Font Mono 16";
      default-profile-uuid = "00000000-0000-0000-0000-000000000001";
      profile-uuids = [ "00000000-0000-0000-0000-000000000001" ];
    };

    dconf.settings."org/gnome/Ptyxis/Profiles/00000000-0000-0000-0000-000000000001" = {
      palette = "nord";
    };

    dconf.settings."org/gnome/desktop/interface" = {
      clock-format = "24h";
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
    };

    dconf.settings."org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    dconf.settings."org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    dconf.settings."org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
    };

    dconf.settings."org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
    };

    dconf.settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "ptyxis --new-window";
      name = "Launch terminal";
    };

    dconf.settings."org/gnome/desktop/privacy" = {
      report-technical-problems = false;
    };

    dconf.settings."org/gnome/system/location" = {
      enabled = false;
    };

    dconf.settings."org/gnome/shell" = {
      enabled-extensions = [
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "window-list@gnome-shell-extensions.gcampax.github.com"
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "org.gnome.Ptyxis.desktop"
        "brave-browser.desktop"
        "code.desktop"
        "org.gnome.Nautilus.desktop"
        "md.obsidian.Obsidian.desktop"
      ];
    };

    dconf.settings."org/gnome/desktop/app-folders" = {
      folder-children = [ "Disk" "Graphics" "Media" "Office" "Settings" "Sync" "System" "Utilities" ];
    };

    dconf.settings."org/gnome/desktop/app-folders/folders/Disk" = {
      name = "Disk";
      apps = [
        "org.gnome.baobab.desktop"
        "org.gnome.DiskUtility.desktop"
        "gparted.desktop"
      ];
    };

    dconf.settings."org/gnome/desktop/app-folders/folders/Graphics" = {
      name = "Graphics";
      apps = [
        "org.gimp.GIMP.desktop"
        "org.inkscape.Inkscape.desktop"
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
        "org.libreoffice.LibreOffice.base.desktop"
        "org.libreoffice.LibreOffice.calc.desktop"
        "org.libreoffice.LibreOffice.draw.desktop"
        "org.libreoffice.LibreOffice.impress.desktop"
        "org.libreoffice.LibreOffice.math.desktop"
        "org.libreoffice.LibreOffice.writer.desktop"
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
        "org.freefilesync.FreeFileSync.RealTimeSync.desktop"
        "syncthing-ui.desktop"
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
