{ ... }:

{
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  powerManagement.resumeCommands = "systemctl restart tailscaled";
}
