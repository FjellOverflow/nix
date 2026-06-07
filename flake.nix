{
  description = "NixOS configurations";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  inputs.nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
  inputs.nix-vscode-extensions = {
    url = "github:nix-community/nix-vscode-extensions";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.home-manager = {
    url = "github:nix-community/home-manager/release-26.05";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-flatpak,
      nix-vscode-extensions,
      home-manager,
    }:
    let
      user = "fjelloverflow";
      commonModules = [
        nix-flatpak.nixosModules.nix-flatpak
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
        { nixpkgs.overlays = [ nix-vscode-extensions.overlays.default ]; }
        ./common.nix
      ];
    in
    {
      nixosConfigurations = {
        vm = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit user; };
          modules = commonModules ++ [ ./machines/vm/default.nix ];
        };
        thinkpad = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit user; };
          modules = commonModules ++ [ ./machines/thinkpad/default.nix ];
        };
        brick = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit user; };
          modules = commonModules ++ [ ./machines/brick/default.nix ];
        };
        gigabyte = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit user; };
          modules = commonModules ++ [ ./machines/gigabyte/default.nix ];
        };
      };
    };
}
