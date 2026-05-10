{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/workstation.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "brick";

  hardware.bluetooth.enable = true;
  services.thermald.enable = true;
}
