{
  description = "Flakefied config.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  # something to pass to home-manager
  let
    pkgs = nixpkgs;
  in
  {
    # create config for mogos
    nixosConfigurations.mogos = nixpkgs.lib.nixosSystem
    {
      modules =
      [
        ./hosts/mogos/default.nix
        home-manager.nixosModules.home-manager {
          # to avoid package bugs due to version mismatch.
          home-manager.useGlobalPkgs = true;
          # to save some space (shared packages)
          home-manager.useUserPackages = true;
          # se.
          home-manager.users.regular = import ./home { inherit pkgs; };
        }
      ];
    };
    nixosConfigurations.default = mogos;

  };
}
