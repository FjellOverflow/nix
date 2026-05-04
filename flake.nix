{
  description = "Snøflak NixOS configurations";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  inputs.nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
  inputs.home-manager = {
    url = "github:nix-community/home-manager/release-25.11";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.agenix = {
    url = "github:ryantm/agenix";
    input.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-flatpak, home-manager, agenix }:
  let
    user = "fjelloverflow";
    commonModules = [
      nix-flatpak.nixosModules.nix-flatpak
      home-manager.nixosModules.home-manager
      agenix.nixosModules.default
      { home-manager.useGlobalPkgs = true; home-manager.useUserPackages = true; }
      ./common.nix
    ];
  in {
    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit user; };
        modules = commonModules ++ [ ./machines/vm/default.nix ];
      };
    };
  };
}
