{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./git.nix
    ./niri.nix
    # ./vscode.nix
  ];

  programs = {
    home-manager.enable = true;

    ssh = {
      enable = true;
      enableDefaultConfig = false;
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
      # interactiveShellInit = ''
      #   cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
      # '';
      loginShellInit = ''
        fnm env --use-on-cd --shell fish | source
      '';
    };

    tmux = {
      enable = true;
      keyMode = "vi";
      mouse = true;
      newSession = true;
    };

    fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
    };

    # nushell = {
    #   enable = true;
    #   shellAliases = {
    #     hx = "helix";
    #   };
    #   settings = {
    #     buffer_editor = "helix";
    #     show_banner = false;
    #   };
    # };

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
      enable = true;
      font.name = "Iosevka Custom";
      settings = {
        window_padding_width = 8;
        cursor_trail = 1;
      };
    };

    wezterm = {
      enable = true;
      extraConfig = ''
        return {
          font_size = 11.0,
          font = wezterm.font_with_fallback {
            "Iosevka Term",
            "Sarasa Term SC",
            "Sarasa Term J",
            "Sarasa Term K",
          },
          color_scheme = "Catppuccin Mocha",
          hide_tab_bar_if_only_one_tab = true,
        }
      '';
    };

    # quickshell = {
    #   enable = true;
    # };

    # zed-editor = {
    #   enable = false;
    # };

    # rbenv = {
    #   enable = true;
    #   plugins = [
    #     {
    #       name = "ruby-build";
    #       src = pkgs.fetchFromGitHub {
    #         owner = "rbenv";
    #         repo = "ruby-build";
    #         rev = "v20250418";
    #         hash = "sha256-TSJ8tUu0yS/i9mTaGTsTHefUSkMC6GseeKPpvBvFeXg=";
    #       };
    #     }
    #   ];
    # };
  };

  # wayland.windowManager.hyprland = {
  #   enable = false;
  #   plugins = [ ];
  #   systemd.variables = [ "--all" ];
  # };
}
