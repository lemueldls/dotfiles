{
  config,
  lib,
  pkgs,
  inputs,
  overlays,
  allowUnfree,
  winapps,
  ...
}:
let
  username = "lemuel";
  homeDirectory = "/home/" + username;
in
{
  imports = [ ./modules/desktop.nix ];

  lib.meta = {
    dotfilesPath = "${homeDirectory}/Projects/dotfiles";
    mkMutableSymlink =
      path:
      config.lib.file.mkOutOfStoreSymlink (
        config.lib.meta.dotfilesPath + lib.removePrefix (toString inputs.self) (toString path)
      );
  };

  nix = {
    package = pkgs.nix;

    gc = {
      automatic = true;
      # frequency = "daily";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      substituters = [ "https://cache.nixos.org" ];
      trusted-users = [
        "root"
        "lemuel"
        "@wheel"
        "nixbld"
      ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
      extra-substituters = [
        # "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
      ];
      extra-trusted-public-keys = [
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
  };

  home = {
    inherit username homeDirectory;

    shell.enableShellIntegration = true;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.05"; # Please read the comment before changing.

    preferXdgDirectories = true;
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
      size = 24;
    };

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      # Nix
      nix
      nixd
      nixfmt-rfc-style
      devenv

      # Build tools
      just

      # KDE Packages
      kdePackages.qtwayland
      kdePackages.qtsvg
      kdePackages.qt6ct
      kdePackages.dolphin

      winapps
    ];

    file = with config.lib.meta; {
      ".config/btop".source = mkMutableSymlink ./configs/btop;
      ".config/fastfetch".source = mkMutableSymlink ./configs/fastfetch;
      ".config/firefox".source = mkMutableSymlink ./configs/firefox;
      # ".config/fish".source = mkMutableSymlink ./configs/fish;
      # ".config/foot".source = mkMutableSymlink ./.config/foot;
      ".config/hypr".source = mkMutableSymlink ./configs/hypr;
      # ".config/micro".source = mkMutableSymlink ./configs/micro;
      ".config/spicetify".source = mkMutableSymlink ./configs/spicetify;
      ".config/thunar".source = mkMutableSymlink ./configs/thunar;
      ".config/uwsm".source = mkMutableSymlink ./configs/uwsm;
      ".config/Code/User/settings.json".source = mkMutableSymlink ./configs/vscode/settings.json;
      ".config/Code/User/keybindings.json".source = mkMutableSymlink ./configs/vscode/keybindings.json;
      ".config/Code/User/flags.conf".source = mkMutableSymlink ./configs/vscode/flags.conf;
      ".config/zed/keymap.json".source = mkMutableSymlink ./configs/zed/keymap.json;
      ".config/zed/settings.json".source = mkMutableSymlink ./configs/zed/settings.json;
      ".config/zen/userChrome.css".source = mkMutableSymlink ./configs/zen/userChrome.css;
      # ".config/starship.toml".source = mkMutableSymlink ./configs/starship.toml;

      "Pictures/Wallpapers".source = mkMutableSymlink ./wallpapers;
    };

    sessionVariables = {
      EDITOR = "helix";
    };
  };

  nixGL = {
    packages = inputs.nixGL.packages;
    defaultWrapper = "mesa";
    # offloadWrapper = "nvidiaPrime";
    # installScripts = [ "mesa" ];
  };

  nixpkgs = {
    inherit overlays;
    config = {
      inherit overlays allowUnfree;
    };
  };

  services = {
    home-manager = {
      autoUpgrade = {
        enable = true;
        frequency = "weekly";
      };
      autoExpire = {
        enable = true;
        frequency = "weekly";
      };
    };
  };
}
