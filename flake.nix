{
  description = "Dotfiles using Home Manager.";

  nixConfig = {
    auto-optimise-store = true;

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [ "https://cache.nixos.org" ];
    trusted-users = [
      "root"
      "@wheel"
      "nixbld"
      "lemuel"
    ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
      "https://lemueldls.cachix.org"
      "https://niri.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "lemueldls.cachix.org-1:aA3BhKvBO5krZ577ISCfJkIFhvYjvwTe7fIfu9J/+Ho="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };

  inputs = {
    # self.submodules = true;

    nixpkgs.url = "nixpkgs/nixos-25.11";
    # nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    assets = {
      url = "github:lemueldls/assets";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # PAM shim for non-NixOS systems
    # Using 'next' branch for full libpam.so.0 API coverage
    pam-shim = {
      url = "github:Cu3PO42/pam_shim/next";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      # url = "github:LuckShiba/niri-flake/includes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix/release-25.11";
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

            # inputs.stylix.homeModules.stylix

            inputs.pam-shim.homeModules.default

            inputs.plasma-manager.homeModules.plasma-manager

            inputs.niri.homeModules.niri
            inputs.dms.homeModules.dank-material-shell
            inputs.dms.homeModules.niri

            inputs.catppuccin.homeModules.catppuccin
          ];
        };
      };
    };
}
