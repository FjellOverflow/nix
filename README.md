Fresh install:

```bash
sudo nano /etc/nixos/configuration.nix

# add git package & save

sudo nixos-rebuild switch

git clone https://github.com/FjellOverflow/snowflak.git && cd snoflak

nano flake.nix

# add mymachine config section

mkdir machines/mymachine
nano machines/mymachine/default.nix

# add stuff & save

sudo cp /etc/nixos/hardware-configuration.nix ./snoflak/machines/mymachine/hardware-configuration.nix

sudo chown $(whoami):users machines/mymachine/hardware-configuration.nix

sudo rm /etc/nixos
sudo ln -s /etc/nixos ~/snoflak

sudo nixos-rebuild switch --flake .#mymachine
```