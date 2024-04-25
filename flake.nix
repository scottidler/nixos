# flake.nix

{
  description = "A comprehensive NixOS and Home Manager configuration for a single system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [];
      };
      hmConfig = home-manager.lib.homeManagerConfiguration {
        inherit pkgs system;
        username = "saidler";
        homeDirectory = "/home/saidler";
        configuration = import ./home.nix { inherit pkgs system; };
      };
    in {
      nixosConfigurations.scottidler = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [
          #/home/saidler/.config/home-manager/hardware-configuration.nix
          ./hardware-configuration.nix
          ./configuration.nix
          hmConfig.home-manager.configuration
        ];
      };
    };
}
