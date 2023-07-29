{
  description = "an attempt at a NixOS Flake";
  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
    extra-substituters = [
      # nix community's cache server
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      chaos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	  ./configuration.nix
          ./hosts/chaos
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.dhaines = import ./home.nix;
          }
        ];
      };
    };
  };
}
