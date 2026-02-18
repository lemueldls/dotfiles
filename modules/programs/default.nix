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
      matchBlocks = {
        "github.com" = {
          port = 443;
          user = "git";
          hostname = "ssh.github.com";
          identityFile = "~/.ssh/git";
        };
        "tangled.org" = {
          user = "git";
          hostname = "tangled.org";
          identityFile = "~/.ssh/git";
          addressFamily = "inet";
        };
        "aur.archlinux.org" = {
          user = "aur";
          identityFile = "~/.ssh/aur";
        };
      };
    };

    jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "Lemuel DLS";
          email = "git@lemueldls.dev";
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
      font.name = "IosevkaTerm Nerd Font";
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
            "IosevkaTerm Nerd Font",
            "Sarasa Term SC",
            "Sarasa Term J",
            "Sarasa Term K",
          },
          color_scheme = "dank-theme",
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
