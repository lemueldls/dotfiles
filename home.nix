{
  config,
  lib,
  pkgs,
  inputs,
  overlays,
  allowUnfree,
  ...
}:
let
  flake = import ./flake.nix;

  username = "lemuel";
  homeDirectory = "/home/" + username;
  dotsDirectory = "${homeDirectory}/Projects/dotfiles";
  assets = inputs.assets.packages.x86_64-linux;
in
{
  imports = [ ./modules/desktop.nix ];

  lib.meta = {
    dotfilesPath = dotsDirectory;
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

    settings = flake.nixConfig;
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
    stateVersion = "25.11"; # Please read the comment before changing.

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
      cachix
      devenv

      # Build tools
      just

      # KDE Packages
      kdePackages.qtwayland
      kdePackages.qtsvg
      kdePackages.qt6ct
      # kdePackages.dolphin
      kdePackages.gwenview

      assets.fonts.iosevka-book
      assets.fonts.iosevka-slim
      assets.fonts.iosevka-code
      assets.fonts.iosevka-term
      # assets.fonts.sarasa-gothic
    ];

    file = with config.lib.meta; {
      ".config/Code/User/settings.json".source = mkMutableSymlink ./configs/vscode/settings.json;
      ".config/Code/User/keybindings.json".source = mkMutableSymlink ./configs/vscode/keybindings.json;
      ".config/Code/User/flags.conf".source = mkMutableSymlink ./configs/vscode/flags.conf;

      ".config/zed/keymap.json".source = mkMutableSymlink ./configs/zed/keymap.json;
      ".config/zed/settings.json".source = mkMutableSymlink ./configs/zed/settings.json;

      ".config/niri/dms".source = mkMutableSymlink ./configs/dms;

      "Pictures/Wallpapers".source = "${assets.wallpapers}/share/wallpapers/assets/contents/images";
    };

    sessionVariables = {
      EDITOR = "helix";
    };
  };

  nixpkgs = {
    inherit overlays;

    config = {
      inherit overlays allowUnfree;
    };
  };

  targets.genericLinux.enable = true;

  # stylix = {
  #   enable = true;

  #   cursor = {
  #     package = pkgs.qogir-icon-theme;
  #     name = "Qogir";
  #     size = 24;
  #   };

  #   targets.niri.enable = false;
  # };

  pamShim.enable = true;

  services = {
    home-manager = {
      autoUpgrade = {
        enable = false;
        frequency = "weekly";
        useFlake = true;
        flakeDir = dotsDirectory;
      };
      autoExpire = {
        enable = true;
        frequency = "weekly";
      };
    };

    # wl-clip-persist = {
    #   enable = true;
    # };

    kdeconnect = {
      enable = true;
      # indicator = true;
    };
  };
}
