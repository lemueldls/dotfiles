{ config, lib, pkgs, ... }: {
  imports = [ ./programs/vscode.nix ];

  programs = {
      home-manager.enable = true;

      ssh = {
        enable = true;
      };

      git = {
        enable = true;
        userName = "Lemuel DLS";
        userEmail = "26912197+lemueldls@users.noreply.github.com";
        lfs.enable = true;
        extraConfig = {
          commit.gpgSign = true;
          safe.directory = "/opt/flutter";
          gpg.format = "ssh";
          merge.ff = true;
          init.defaultBranch = "main";
          core = {
            editor = "helix";
            compression = 9;
            whitespace = "error";
            preloadindex = true;
          };
          advice = {
            addEmptyPathspec = false;
            pushNonFastForward = false;
            statusHints = false;
          };
          status = {
            branch = true;
            showStash = true;
            showUntrackedFiles = "all";
          };
          diff = {
            context = 3;
            renames = "copies";
            interHunkContext = 10;
          };
          interactive = {
            singlekey = true;
          };
          push = {
            autoSetupRemote = true;
            default = "current";
            followTags = true;
          };
          pull = {
            default = "current";
            rebase = false;
          };
          rebase = {
            autoStash = true;
            missingCommitsCheck = "warn";
          };
          log = {
            abbrevCommit = true;
            graphColors = "blue,yellow,cyan,magenta,green,red";
          };
          "color \"decorate\"" = {
            HEAD = "red";
            branch = "blue";
            tag = "green";
            remoteBranch = "magenta";
          };
          "color \"branch\"" = {
            current = "magenta";
            local = "default";
            remote = "yellow";
            upstream = "green";
            plain = "blue";
          };
          # branch.sort = "-commiterdate";
          tag = {
            gpgsign = true;
            # sort = "-taggerdate";
          };
          pager = {
            branch = false;
            tag = false;
          };
        };
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
          set_kitty_colors = ''
            set color_file ~/.cache/ags/user/generated/kitty-colors.conf
            if test -f $color_file
                kitty @ set-colors --all --configured $color_file
            else
                echo "Color scheme file not found: $color_file"
            end
          '';
          is_interactive = ''
            set fish_greeting
              # Only run starship init if it exists
              type -q starship; and starship init fish | source

              # Only try to read sequences if the file exists
              set -l seq_file ~/.cache/ags/user/generated/terminal/sequences.txt
              if test -f $seq_file
                  cat $seq_file
              end
            end
          '';
        };
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

      zoxide = { enable = true; };

      starship = { enable = true; };

      direnv = { enable = true; };

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
      plugins = [];
      systemd.variables = ["--all"];
    };
}
