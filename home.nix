{
  config,
  lib,
  pkgs,
  inputs,
  overlays,
  allowUnfree,
  # unstable,
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
    # You should not change this value, even if you update Home Manager. If you
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "26.05"; # Please read the comment before changing.

    preferXdgDirectories = true;
    pointerCursor = {
      enable = true;
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
      size = 24;
    };

    # The home.packages option allows you to install Nix packages into
    # your environment.
    packages = with pkgs; [
      # Nix
      nix
      nixd
      nixfmt
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

      proton-pass-cli

      assets.fonts.iosevka-book
      assets.fonts.iosevka-slim
      assets.fonts.iosevka-code
      assets.fonts.iosevka-term
      # assets.fonts.sarasa-gothic
    ];

    file = with config.lib.meta; {
      # VS Code
      ".config/Code/User/settings.json".source = mkMutableSymlink ./configs/vscode/settings.json;
      ".config/Code/User/keybindings.json".source = mkMutableSymlink ./configs/vscode/keybindings.json;
      ".config/Code/User/flags.conf".source = mkMutableSymlink ./configs/vscode/flags.conf;

      # Zed
      ".config/zed/keymap.json".source = mkMutableSymlink ./configs/zed/keymap.json;
      ".config/zed/settings.json".source = mkMutableSymlink ./configs/zed/settings.json;

      # DankMaterialShell
      ".config/DankMaterialShell/clsettings.json".source = mkMutableSymlink ./configs/dms/clsettings.json;
      ".config/DankMaterialShell/plugin_settings.json".source =
        mkMutableSymlink ./configs/dms/plugin_settings.json;
      ".config/DankMaterialShell/settings.json".source = mkMutableSymlink ./configs/dms/settings.json;

      # Assets
      "Pictures/Wallpapers".source = "${assets.wallpapers}/share/wallpapers/assets/contents/images";
    };

    sessionVariables = {
      EDITOR = "helix";
      PROTON_PASS_LINUX_KEYRING = "dbus";

      ANDROID_HOME = "$HOME/Android/Sdk";
      ANDROID_NDK_HOME = "$HOME/Android/Sdk/ndk/25.0.8775105";
    };
  };

  nixpkgs = {
    inherit overlays;

    config = {
      inherit overlays allowUnfree;
    };
  };

  targets.genericLinux.enable = true;

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

    # ssh-agent.enable = true;

    proton-pass-agent = {
      enable = true;
      extraArgs = [
        "--create-new-identities"
        "Personal"
      ];
    };

    kdeconnect = {
      enable = true;
      # indicator = true;
    };
  };
}
