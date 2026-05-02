{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/workstation.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "vm";

  environment.systemPackages = with pkgs; [
    spice-vdagent
    spice-gtk
  ];

  services.spice-webdavd.enable = true;
  services.spice-vdagentd.enable = true;
}
