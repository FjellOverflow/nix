{ pkgs, user, ... }:

{
  services.syncthing = {
    enable = true;
    user = user;
    dataDir = "/home/${user}/Syncthing";
    configDir = "/home/${user}/.config/syncthing";
  };
  environment.systemPackages = with pkgs; [ syncthing ];
}
