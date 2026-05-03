{
  description = "Snøflak NixOS configurations";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  inputs.nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";

  outputs = { self, nixpkgs, nix-flatpak }: {
    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          ./common.nix
          ./machines/vm/default.nix
        ];
      };
    };
  };
}
