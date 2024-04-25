{
  description = "System configuration with NixOS and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, poetry2nix, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        overlays = [ poetry2nix.overlay ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        hmConfig = home-manager.lib.homeManagerConfiguration {
          inherit pkgs system;
          username = "saidler";
          homeDirectory = "/home/saidler";
          configuration = { config, lib, ... }:
            import ./home.nix {
              inherit config pkgs lib;
            };
        };
      in {
        nixosConfigurations = {
          scottidler = nixpkgs.lib.nixosSystem {
            inherit system pkgs;
            modules = [ ./configuration.nix ];
          };
        };
        homeManagerConfigurations = {
          saidler = hmConfig;
        };
      });
}

