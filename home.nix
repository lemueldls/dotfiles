{ config, lib, pkgs, inputs, overlays, allowUnfree, ... }: {
  imports = [ ./modules/desktop.nix ];

  lib.meta = {
    homePath = "/home/lemuel/Projects/dotfiles/home";
    mkMutableSymlink = path: config.lib.file.mkOutOfStoreSymlink
      (config.lib.meta.homePath + lib.removePrefix (toString inputs.self) (toString path));
  };

  nix = {
    package = pkgs.nix;

    gc = {
      automatic = true;
      # frequency = "daily";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];

      substituters = [ "https://cache.nixos.org" ];
      trusted-users = [ "root" "lemuel" "@wheel" "nixbld" ];
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

  home = rec {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    username = "lemuel";
    homeDirectory = "/home/" + username;

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
        # (config.lib.nixGl.wrapOffload )
        # (config.lib.nixGl.wrappers. )

        nix
        nil
        nixd
        nixfmt-rfc-style
        devenv

        just

        kdePackages.qtwayland
        kdePackages.qtsvg
        kdePackages.qt6ct
        kdePackages.qtstyleplugin-kvantum
        # libsForQt5.qt5ct
        # catppuccin-qt5ct
        kdePackages.dolphin
        # libsForQt5.dolphin

        nwg-look

        # (catppuccin-kvantum.override { accent = "teal"; variant = "mocha"; })

        (config.lib.nixGL.wrap steam)
    ];

    file = with config.lib.meta; {
        # ".ags" = { source = ./home/.local; recursive = true; };

        ".config/ags".source = mkMutableSymlink ./.config/ags;
        ".config/btop".source = mkMutableSymlink ./.config/btop;
        # ".config/fish".source = mkMutableSymlink ./.config/fish;
        ".config/fastfetch".source = mkMutableSymlink ./.config/fastfetch;
        # ".config/fontconfig".source = mkMutableSymlink ./.config/fontconfig;
        ".config/foot".source = mkMutableSymlink ./.config/foot;
        ".config/ghostty".source = mkMutableSymlink ./.config/ghostty;
        ".config/gowall".source = mkMutableSymlink ./.config/gowall;
        ".config/gtk-3.0".source = mkMutableSymlink ./.config/gtk-3.0;
        ".config/gtk-4.0".source = mkMutableSymlink ./.config/gtk-4.0;
        ".config/hypr".source = mkMutableSymlink ./.config/hypr;
        ".config/kitty".source = mkMutableSymlink ./.config/kitty;
        ".config/lunarfetch".source = mkMutableSymlink ./.config/lunarfetch;
        ".config/matugen".source = mkMutableSymlink ./.config/matugen;
        ".config/presets".source = mkMutableSymlink ./.config/presets;
        ".config/qt5ct".source = mkMutableSymlink ./.config/qt5ct;
        ".config/qt6ct".source = mkMutableSymlink ./.config/qt6ct;
        # ".config/starship.toml".source = mkMutableSymlink ./.config/starship.toml;

        ".local/bin".source = mkMutableSymlink ./.local/bin;
        ".local/share/glib-2.0/schemas".source = mkMutableSymlink ./.local/share/glib-2.0/schemas;
        ".local/state/ags".source = mkMutableSymlink ./.local/state/ags;

        "Pictures/Wallpapers".source = mkMutableSymlink ./Pictures/Wallpapers;
    };

    sessionVariables = {
      EDITOR = "helix";
    };
  };

  nixGL = {
    packages = inputs.nixGL.packages;
    defaultWrapper = "mesa";
    # offloadWrapper = "nvidiaPrime";
    installScripts = [ "mesa" ];
  };

  nixpkgs = {
    inherit overlays;
    config = { inherit overlays allowUnfree; };
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

    # linux-wallpaperengine = {
    #   enable = true;
    #   package = (config.lib.nixGL.wrap pkgs.linux-wallpaperengine);
    #   clamping = "clamp";
    #   assetsPath = "${home.homeDirectory}/.local/share/Steam/steamapps/common/wallpaper_engine/assets";
    #   wallpapers = [
    #     { # https://steamcommunity.com/sharedfiles/filedetails/?id=3371368351&searchtext=catppuccin
    #       monitor = "DP-1";
    #       wallpaperId = "3371368351";
    #       fps = 60;
    #       audio.silent = true;
    #     }
    #   ];
    # };
  };

  qt = {
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
}
