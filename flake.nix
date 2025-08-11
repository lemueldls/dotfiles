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
  };

  outputs = inputs@{ nixpkgs, home-manager, nixGL, catppuccin, ... }:
    let
      # lib = nixpkgs.lib;
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      system = "x86_64-linux";
      overlays = [nixGL.overlay];
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = allowUnfree;
        config.allowUnfreePredicate = allowUnfreePredicate;
      };
    in {
      homeConfigurations = {
        lemuel = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = { inherit inputs overlays allowUnfree; };

          modules = [
            ./home.nix
            catppuccin.homeModules.catppuccin
          ];
        };
      };
    };
}
