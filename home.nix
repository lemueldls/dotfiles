{ config, pkgs, inputs, overlays, allowUnfree, ... }: {
  imports = [ ./modules/desktop.nix ];

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
    # pointerCursor = {
    #   gtk.enable = true;
    #   package = pkgs.qogir-icon-theme;
    #   name = "Qogir";
    #   size = 24;
    # };

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

        moonfire-nvr
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        ".config/kitty/kitty.conf".source = ./home/.config/kitty/kitty.conf;

        # "Pictures/Wallpapers".source = ./home/Pictures/Wallpapers;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
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
