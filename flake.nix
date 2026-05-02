{
  description = "Snøflak NixOS configurations";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        modules = [
          ./common.nix
          ./machines/vm/default.nix
        ];
      };
    };
  };
}
