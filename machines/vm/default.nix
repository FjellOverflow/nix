{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/workstation.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  
  networking.hostName = "vm";

  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };
  console.keyMap = "no";

  services.spice-webdavd.enable = true;
}
