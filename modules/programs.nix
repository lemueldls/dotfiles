{ config, pkgs, ... }: {
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
      settings = {

      };
      extraConfig = ''
        monitor=,preferred,auto,1
        workspace=DP-1,1

        exec-once = hyprpaper
        exec-once = hyprpanel
        exec-once = hypridle
        exec-once = hyprsunset
        exec-once = clipse -listen
        exec-once = hyprctl setcursor Qogir 14
        exec-once = /usr/lib/kdeconnectd

        env = GDK_BACKEND,wayland,x11
        env = SDL_VIDEODRIVER,wayland
        env = CLUTTER_BACKEND,wayland
        env = MOZ_ENABLE_WAYLAND,1
        env = MOZ_DISABLE_RDD_SANDBOX,1
        env = _JAVA_AWT_WM_NONREPARENTING,1
        env = QT_AUTO_SCREEN_SCALE_FACTOR,1
        env = QT_QPA_PLATFORM,wayland
        env = QT_STYLE_OVERRIDE,kvantum
        # env = LIBVA_DRIVER_NAME,nvidia
        # env = GBM_BACKEND,nvidia-drm
        # env = __GLX_VENDOR_LIBRARY_NAME,nvidia
        # env = __NV_PRIME_RENDER_OFFLOAD,1
        # env = __VK_LAYER_NV_optimus,NVIDIA_only
        # env = PROTON_ENABLE_NGX_UPDATER,1
        # env = NVD_BACKEND,direct
        # env = __GL_GSYNC_ALLOWED,1
        # env = __GL_VRR_ALLOWED,0
        # env = WLR_DRM_NO_ATOMIC,1
        env = WLR_USE_LIBINPUT,1
        # env = XWAYLAND_NO_GLAMOR,1 (no help to TradingView)
        # env = __GL_MaxFramesAllowed,1
        # env = WLR_RENDERER_ALLOW_SOFTWARE,1
        # env = XDG_SESSION_TYPE,wayland
        env = XDG_CURRENT_DESKTOP,Hyprland
        env = XDG_SESSION_DESKTOP,Hyprland
        env = QT_QPA_PLATFORM_PLUGIN_PATH,/lib/qt/plugins/platforms
        env = QT_QPA_PLATFORMTHEME,gtk3
        env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
        # env = WLR_DRM_DEVICES,/dev/dri/card0

        input {
            kb_file=
            kb_layout=
            kb_variant=
            kb_model=
            kb_options=
            kb_rules=

            follow_mouse=1

            touchpad {
                natural_scroll=yes
            }

           # sensitivity=0 # -1.0 - 1.0, 0 means no modification.
        }

        general {
            # main_mod=SUPER

            gaps_in = 4
            gaps_out = 0, 8, 8, 8
            border_size = 2
            col.active_border = 0x6600a896
            col.inactive_border = 0x6611111b

            # apply_sens_to_raw=0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)

            # damage_tracking=full # leave it on full unless you hate your GPU and want to make it suffer
        }

        decoration {
            rounding=8
            active_opacity=1
            inactive_opacity=0.98
            fullscreen_opacity=1.0
            # blur=true
            # blur_size=8
            # blur_passes=1
            # blur_new_optimizations=true
        }

        animations {
            enabled=true
            animation=windows,1,7,default
            animation=border,1,10,default
            animation=fade,1,10,default
            animation=workspaces,1,6,default
        }

        ecosystem {
            # no_update_news=true
        }

        dwindle {
            pseudotile=1 # enable pseudotiling on dwindle
        }

        gestures {
            workspace_swipe=yes
        }

        misc {
            disable_hyprland_logo=true
        }

        plugin:dynamic-cursors {
            enabled = true

            mode = rotate
        }

        # example window rules
        # for windows named/classed as abc and xyz
        #windowrule=move 69 420,abc
        #windowrule=size 420 69,abc
        #windowrule=tile,xyz
        #windowrule=float,abc
        #windowrule=pseudo,abc
        #windowrule=monitor 0,xyz

        windowrulev2 = float,class:(clipse) # ensure you have a floating window class set if you want this behavior
        windowrulev2 = size 600 300,class:(clipse) # set the size of the window as necessary

        # some nice mouse binds
        bindm=SUPER,mouse:272,movewindow
        bindm=SUPER,mouse:273,resizewindow

        # example binds
        bind=SUPER,Q,exec,kitty
        bind=SUPER,C,killactive,
        bind = SUPER, M, exec, uwsm stop
        bind=SUPER,E,exec,dolphin
        bind=SUPER,F,togglefloating,
        bind = SUPER, V, exec, kitty --class clipse -e 'clipse'
        # bind=SUPER,R,exec,wofi --show drun -o DP-3
        bind=SUPER,R,exec,rofi -show drun
        bind=ALT,SPACE,exec,rofi -show drun
        bind=SUPER,P,pseudo,
        bind=SUPERSHIFT,S,exec,grimblast copy area

        bind=SUPER,left,movefocus,l
        bind=SUPER,right,movefocus,r
        bind=SUPER,up,movefocus,u
        bind=SUPER,down,movefocus,d

        bind=SUPER,1,workspace,1
        bind=SUPER,2,workspace,2
        bind=SUPER,3,workspace,3
        bind=SUPER,4,workspace,4
        bind=SUPER,5,workspace,5
        bind=SUPER,6,workspace,6
        bind=SUPER,7,workspace,7
        bind=SUPER,8,workspace,8
        bind=SUPER,9,workspace,9
        bind=SUPER,0,workspace,10

        bind=SUPERSHIFT,1,movetoworkspace,1
        bind=SUPERSHIFT,2,movetoworkspace,2
        bind=SUPERSHIFT,3,movetoworkspace,3
        bind=SUPERSHIFT,4,movetoworkspace,4
        bind=SUPERSHIFT,5,movetoworkspace,5
        bind=SUPERSHIFT,6,movetoworkspace,6
        bind=SUPERSHIFT,7,movetoworkspace,7
        bind=SUPERSHIFT,8,movetoworkspace,8
        bind=SUPERSHIFT,9,movetoworkspace,9
        bind=SUPERSHIFT,0,movetoworkspace,10

        bind=SUPER,mouse_down,workspace,e+1
        bind=SUPER,mouse_up,workspace,e-1

        # /usr/bin/pulseaudio-ctl mute ==>  Toggle status of mute
        # /usr/bin/pulseaudio-ctl mute-input ==>  Toggle status of mute for mic
        # /usr/bin/pulseaudio-ctl up   ==>  Increase vol by 5 %
        # /usr/bin/pulseaudio-ctl down ==>  Decrease vol by 5 %

        # Keyboard backlight
        bind = , keyboard_brightness_up_shortcut, exec, brightnessctl -d *::kbd_backlight set +33%
        bind = , keyboard_brightness_down_shortcut, exec, brightnessctl -d *::kbd_backlight set 33%-

        # Volume and Media Control
        bind = , XF86AudioRaiseVolume, exec, pamixer -i 5
        bind = , XF86AudioLowerVolume, exec, pamixer -d 5
        bind = , XF86AudioMicMute, exec, pamixer --default-source -m
        bind = , XF86AudioMute, exec, pamixer -t
        bind = , XF86AudioPlay, exec, playerctl play-pause
        bind = , XF86AudioPause, exec, playerctl play-pause
        bind = , XF86AudioNext, exec, playerctl next
        bind = , XF86AudioPrev, exec, playerctl previous

        # Screen brightness
        bind = , XF86MonBrightnessUp, exec, brightnessctl s +5%
        bind = , XF86MonBrightnessDown, exec, brightnessctl s 5%-
      '';
    };
}
