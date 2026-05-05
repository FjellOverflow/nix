{ pkgs, user, ... }:

{
  services.syncthing = {
    enable = true;
    user = user;
    dataDir = "/home/${user}/Syncthing";
  };
  environment.systemPackages = with pkgs; [ syncthing ];
}
