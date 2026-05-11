{ pkgs, lib, ... }:

{
  imports = [
    ../modules/gnome.nix
    ../modules/mullvad.nix
    ../modules/syncthing.nix
    ../modules/terminal.nix
    ../modules/brave.nix
    ../modules/vscodium.nix
  ];

  networking.networkmanager.enable = true;

  services.xserver.xkb = {
    layout = lib.mkDefault "no";
    variant = lib.mkDefault "";
  };
  console.keyMap = lib.mkDefault "no";

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  documentation.nixos.enable = false;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  environment.systemPackages = with pkgs; [
    gparted
    mise
  ];

  services.flatpak.packages = [
    "com.bitwarden.desktop"
    "com.spotify.Client"
    "com.usebruno.Bruno"
    "md.obsidian.Obsidian"
    "org.freefilesync.FreeFileSync"
    "org.gimp.GIMP"
    "org.inkscape.Inkscape"
    "org.libreoffice.LibreOffice"
    "org.videolan.VLC"
  ];
}
