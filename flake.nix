{
  description = "Home Manager configuration";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      # flake = true;
      url = "github:nix-community/home-manager";
      # url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    caelestia-cli = {
      url = ./cli;
      # url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = ./shell;
      # url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixGL,
      catppuccin,
      caelestia-cli,
      caelestia-shell,
      winapps,
      ...
    }:
    let
      # lib = nixpkgs.lib;
      allowUnfree = true;
      system = "x86_64-linux";
      overlays = [ nixGL.overlay ];
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = allowUnfree;
      };
    in
    {
      homeConfigurations = {
        lemuel = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs overlays allowUnfree;
            inherit caelestia-cli caelestia-shell winapps;
          };

          modules = [
            ./home.nix
            catppuccin.homeModules.catppuccin
            caelestia-shell.homeManagerModules.default
          ];
        };
      };
    };
}
