{ config, pkgs, ... }:

{
  imports = [ ./modules/theme.nix ];

  home = {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    username = "lemuel";
    homeDirectory = "/home/lemuel";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
        # # Adds the 'hello' command to your environment. It prints a friendly
        # # "Hello, world!" when run.
        # pkgs.hello

        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')

        nix
        nil
        nixd

        just
        nushell
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/lemuel/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      EDITOR = "helix";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Lemuel DLS";
    userEmail = "26912197+lemueldls@users.noreply.github.com";
    lfs.enable = true;
    # config = {
    #   commit.gpgsign = true;
    #   tag.gpgsign = true;
    #   pull.rebase = false;
    #   push.autoSetupRemote = true;
    #   safe.directory = "/opt/flutter";
    #   gpg.format = "ssh";
    #   merge.ff = true;
    #   core.editor = "helix";
    #   init.defaultBranch = "main";
    # };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      source=/home/lemuel/Projects/hyprland/themes/mocha.conf

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
          no_update_news=true
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
