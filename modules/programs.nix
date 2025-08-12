{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./programs/git.nix
    ./programs/caelestia.nix
    ./programs/vscode.nix
  ];

  programs = {
    home-manager.enable = true;

    ssh = {
      enable = true;
    };

    jujutsu = {
      enable = true;
      settings = {
        user = {
          email = "26912197+lemueldls@users.noreply.github.com";
          name = "Lemuel DLS";
        };
      };
    };

    fish = {
      enable = true;
      shellAliases = {
        hx = "helix";
      };
      functions = {
        fish_greeting = "";
        fish_user_key_bindings = ''
          bind \cH backward-kill-word
          bind ctrl-c __fish_cancel_commandline
        '';
      };
      interactiveShellInit = ''
        cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
      '';
      loginShellInit = ''
        fnm env --use-on-cd --shell fish | source
      '';
    };

    nushell = {
      enable = true;
      shellAliases = {
        hx = "helix";
      };
      settings = {
        buffer_editor = "helix";
        show_banner = false;
      };
    };

    zoxide = {
      enable = true;
    };

    starship = {
      enable = true;
    };

    direnv = {
      enable = true;
    };

    kitty = {
      enable = false;
      font.name = "Iosevka Custom";
      package = (config.lib.nixGL.wrap pkgs.kitty);
      settings = {
        window_padding_width = 8;
      };
    };

    wezterm = {
      enable = true;
      package = (config.lib.nixGL.wrap pkgs.wezterm);
      extraConfig = ''
        return {
          font_size = 11.0,
          font = wezterm.font_with_fallback { "Iosevka Term", "Noto Sans Mono CJK" },
          color_scheme = "Catppuccin Mocha",
          hide_tab_bar_if_only_one_tab = true,
        }
      '';
    };

    quickshell = {
      enable = true;
      package = (config.lib.nixGL.wrap pkgs.quickshell);
    };

    zed-editor = {
      enable = false;
    };

    rbenv = {
      enable = true;
      plugins = [
        {
          name = "ruby-build";
          src = pkgs.fetchFromGitHub {
            owner = "rbenv";
            repo = "ruby-build";
            rev = "v20250418";
            hash = "sha256-TSJ8tUu0yS/i9mTaGTsTHefUSkMC6GseeKPpvBvFeXg=";
          };
        }
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = false;
    package = (config.lib.nixGL.wrap pkgs.hyprland);
    portalPackage = (config.lib.nixGL.wrap pkgs.xdg-desktop-portal-hyprland);
    plugins = [ ];
    systemd.variables = [ "--all" ];
  };
}
