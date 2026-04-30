{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    spice-vdagent
    spice-gtk
  ];

  services.spice-webdavd.enable = true;
  services.spice-vdagentd.enable = true;
}
