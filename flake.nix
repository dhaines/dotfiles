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
    impermanence = {
      url = "github:nix-community/impermanence";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, impermanence, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs { inherit system ; config = { allowUnfree = true; }; };
    in
    {
      nixosConfigurations = {

        impermanent = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            ./impermanence.nix
            ./hosts/impermanent

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.dhaines = import ./home.nix;
            }

            impermanence.nixosModules.impermanence
            {
              environment.persistence."/persist" = {
                directories = [];
              };
              environment.etc."machine-id".source = "/persist/etc/machine-id";
              environment.etc."machine-id".enable = false;
            }
          ];
        };

        chaos = lib.nixosSystem {
          inherit system;
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
