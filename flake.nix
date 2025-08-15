{
  description = "Home Manager configuration";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      flake = true;
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    caelestia-cli = {
      url = ./cli;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = ./shell;
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
            inherit caelestia-cli caelestia-shell;
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
