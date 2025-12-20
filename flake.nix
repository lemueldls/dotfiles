{
  description = "Home Manager configuration";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # PAM shim for non-NixOS systems
    # Using 'next' branch for full libpam.so.0 API coverage
    pam-shim = {
      url = "github:Cu3PO42/pam_shim/next";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      # url = "github:sodiboo/niri-flake";
      url = "github:LuckShiba/niri-flake/includes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-cli = {
      # url = ./cli;
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      # url = ./shell;
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    inputs:
    let
      system = "x86_64-linux";
      overlays = [ ];
      allowUnfree = true;
      pkgs = import inputs.nixpkgs {
        inherit system overlays;
        config.allowUnfree = allowUnfree;
      };
    in
    {
      homeConfigurations = {
        lemuel = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs overlays allowUnfree;
          };

          modules = [
            ./home.nix

            inputs.pam-shim.homeModules.default

            inputs.niri.homeModules.niri

            inputs.caelestia-shell.homeManagerModules.default
            inputs.dms.homeModules.dank-material-shell
            inputs.dms.homeModules.niri

            inputs.catppuccin.homeModules.catppuccin
          ];
        };
      };
    };
}
