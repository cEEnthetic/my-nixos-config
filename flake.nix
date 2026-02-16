{
  description = "Flakefied config.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  let
    pkgs = nixpkgs;
  in
  {
    nixosConfigurations.mogos = nixpkgs.lib.nixosSystem
    {
      modules =
      [
        ./hosts/mogos/default.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.regular = import ./home { inherit pkgs; };
        }
      ];
    };
  };
}
