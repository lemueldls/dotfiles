{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  programs.niri = {
    enable = true;
    # niri-unstable is needed for `background-effect` (blur) rules and other
    # features not yet in niri-stable 25.08
    package = pkgs.niri-unstable;

    settings = {
      # ────────────── Startup Applications ──────────────
      # https://github.com/YaLTeR/niri/wiki/Configuration:-Miscellaneous#spawn-sh-at-startup
      spawn-at-startup = [
        { command = [ "noctalia" ]; }
        # { command = [ "/usr/lib/polkit-kde-authentication-agent-1 &" ]; }
      ];

      # ────────────── Input Configuration ──────────────
      # https://github.com/YaLTeR/niri/wiki/Configuration:-Input
      input = {
        keyboard = {
          # Enable numlock on startup
          numlock = true;
        };

        touchpad = {
          # Enable tap-to-click
          tap = true;
          # Enable natural (macOS-style) scrolling
          natural-scroll = true;
        };

        # Automatically focus windows under the mouse pointer
        focus-follows-mouse.enable = true;
        # Enable workspace back & forth switching
        workspace-auto-back-and-forth = true;
      };

      # ────────────── Switch Events ──────────────
      # https://github.com/YaLTeR/niri/wiki/Configuration:-Switch-Events
      switch-events = {
        lid-close.action.spawn = [
          "noctalia"
          "msg"
          "session"
          "lock-and-suspend"
        ];
      };

      # ────────────── Layout Configuration ──────────────
      # https://github.com/YaLTeR/niri/wiki/Configuration:-Layout
      layout = {
        # Gap between windows
        gaps = 16;
        # Don't auto-center focused column
        center-focused-column = "never";

        # Needed for noctalia-shell to set the wallpaper
        background-color = "transparent";

        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
      };

      # ────────────── Animations ──────────────
      # https://github.com/YaLTeR/niri/wiki/Configuration:-Animations
      animations = {
        workspace-switch.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 1000;
          epsilon = 0.0001;
        };
        window-open.kind.easing = {
          duration-ms = 200;
          curve = "ease-out-quad";
        };
        window-close.kind.easing = {
          duration-ms = 200;
          curve = "ease-out-cubic";
        };
        horizontal-view-movement.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 900;
          epsilon = 0.0001;
        };
        window-movement.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
        window-resize.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 1000;
          epsilon = 0.0001;
        };
        config-notification-open-close.kind.spring = {
          damping-ratio = 0.6;
          stiffness = 1200;
          epsilon = 0.001;
        };
        screenshot-ui-open.kind.easing = {
          duration-ms = 300;
          curve = "ease-out-quad";
        };
        overview-open-close.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 900;
          epsilon = 0.0001;
        };
      };

      # ────────────── Keybindings ──────────────
      # https://github.com/YaLTeR/niri/wiki/Configuration:-Key-Bindings
      # https://docs.noctalia.dev/getting-started/keybinds/
      binds = {
        "Mod+Shift+ESCAPE".action.show-hotkey-overlay = [ ];

        # ─── Applications ───
        "Mod+Return" = {
          hotkey-overlay.title = "Open Terminal: Wezterm";
          action.spawn = "wezterm";
        };
        "Mod+B" = {
          hotkey-overlay.title = "Open Browser: Zen";
          action.spawn = "zen-browser";
        };

        # ─── Noctalia ───
        "Mod+Shift+Return" = {
          hotkey-overlay.title = "Open Wallpaper Selector: noctalia wallpaper toggle";
          action.spawn-sh = "noctalia msg panel-toggle wallpaper";
        };
        "Mod+S" = {
          hotkey-overlay.title = "Open Control Center: noctalia controlCenter";
          action.spawn-sh = "noctalia msg panel-toggle control-center";
        };
        "Mod+Shift+S" = {
          hotkey-overlay.title = "Open Settings: noctalia settings";
          action.spawn-sh = "noctalia msg settings-toggle";
        };
        "Mod+CTRL+Return" = {
          hotkey-overlay.title = "Open App Launcher: noctalia launcher";
          action.spawn-sh = "noctalia msg panel-toggle launcher";
        };
        "Mod+D" = {
          hotkey-overlay.title = "Open App Launcher: noctalia launcher";
          action.spawn = [
            "noctalia"
            "msg"
            "panel-toggle"
            "launcher"
          ];
        };
        "Mod+ALT+L" = {
          hotkey-overlay.title = "Lock Screen: noctalia lock";
          action.spawn-sh = "noctalia msg session lock";
        };
        "Mod+Shift+Q" = {
          hotkey-overlay.title = "Session Menu: noctalia sessionMenu";
          action.spawn-sh = "noctalia msg panel-toggle session";
        };
        "Mod+V" = {
          hotkey-overlay.title = "Clipboard History: noctalia clipboard";
          action.spawn-sh = "noctalia msg panel-toggle clipboard";
        };
        "Mod+Period" = {
          hotkey-overlay.title = "Emoji Picker: noctalia emoji";
          action.spawn-sh = "noctalia msg panel-toggle launcher /emo";
        };

        # ─── Media Controls ───
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn-sh = "noctalia msg volume-up";
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn-sh = "noctalia msg volume-down";
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn-sh = "noctalia msg volume-mute";
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn-sh = "noctalia msg mic-mute";
        };
        "XF86AudioNext" = {
          allow-when-locked = true;
          action.spawn-sh = "noctalia msg media next";
        };
        "XF86AudioPrev" = {
          allow-when-locked = true;
          action.spawn-sh = "noctalia msg media previous";
        };
        "XF86AudioPlay" = {
          allow-when-locked = true;
          action.spawn-sh = "noctalia msg media toggle";
        };
        "XF86AudioPause" = {
          allow-when-locked = true;
          action.spawn-sh = "noctalia msg media toggle";
        };

        # ─── Brightness Controls ───
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action.spawn-sh = "noctalia msg brightness-up";
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action.spawn-sh = "noctalia msg brightness-down";
        };

        # ─── Window Movement and Focus ───
        "Mod+Q".action.close-window = [ ];

        "Mod+Left".action.focus-column-left = [ ];
        "Mod+H".action.focus-column-left = [ ];
        "Mod+Right".action.focus-column-right = [ ];
        "Mod+L".action.focus-column-right = [ ];
        "Mod+Up".action.focus-window-up = [ ];
        "Mod+K".action.focus-window-up = [ ];
        "Mod+Down".action.focus-window-down = [ ];
        "Mod+J".action.focus-window-down = [ ];

        "Mod+CTRL+Left".action.move-column-left = [ ];
        "Mod+CTRL+H".action.move-column-left = [ ];
        "Mod+CTRL+Right".action.move-column-right = [ ];
        "Mod+CTRL+L".action.move-column-right = [ ];
        "Mod+CTRL+UP".action.move-window-up = [ ];
        "Mod+CTRL+K".action.move-window-up = [ ];
        "Mod+CTRL+Down".action.move-window-down = [ ];
        "Mod+CTRL+J".action.move-window-down = [ ];

        "Mod+Home".action.focus-column-first = [ ];
        "Mod+End".action.focus-column-last = [ ];
        "Mod+CTRL+Home".action.move-column-to-first = [ ];
        "Mod+CTRL+End".action.move-column-to-last = [ ];

        "Mod+Shift+Left".action.focus-monitor-left = [ ];
        "Mod+Shift+Right".action.focus-monitor-right = [ ];
        "Mod+Shift+UP".action.focus-monitor-up = [ ];
        "Mod+Shift+Down".action.focus-monitor-down = [ ];

        "Mod+Shift+CTRL+Left".action.move-column-to-monitor-left = [ ];
        "Mod+Shift+CTRL+Right".action.move-column-to-monitor-right = [ ];
        "Mod+Shift+CTRL+UP".action.move-column-to-monitor-up = [ ];
        "Mod+Shift+CTRL+Down".action.move-column-to-monitor-down = [ ];

        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];

        "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
        "Mod+BracketRight".action.consume-or-expel-window-right = [ ];

        "Mod+Comma".action.consume-window-into-column = [ ];
        # Mod+Period is used for the emoji picker above;
        # Mod+BracketRight (consume-or-expel) still covers expelling.

        "Mod+R".action.switch-preset-column-width = [ ];
        "Mod+Shift+R".action.switch-preset-column-width-back = [ ];

        "Mod+Ctrl+Shift+R".action.switch-preset-window-height = [ ];
        "Mod+Ctrl+R".action.reset-window-height = [ ];

        # ─── Workspace Switching ───
        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-workspace-down = [ ];
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-workspace-up = [ ];
        };
        "Mod+CTRL+WheelScrollDown" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-down = [ ];
        };
        "Mod+CTRL+WheelScrollUp" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-up = [ ];
        };

        "Mod+WheelScrollRight".action.focus-column-right = [ ];
        "Mod+WheelScrollLeft".action.focus-column-left = [ ];
        "Mod+CTRL+WheelScrollRight".action.move-column-right = [ ];
        "Mod+CTRL+WheelScrollLeft".action.move-column-left = [ ];

        "Mod+Shift+WheelScrollDown".action.focus-column-right = [ ];
        "Mod+Shift+WheelScrollUp".action.focus-column-left = [ ];
        "Mod+CTRL+Shift+WheelScrollDown".action.move-column-right = [ ];
        "Mod+CTRL+Shift+WheelScrollUp".action.move-column-left = [ ];

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+CTRL+1".action.move-column-to-workspace = 1;
        "Mod+CTRL+2".action.move-column-to-workspace = 2;
        "Mod+CTRL+3".action.move-column-to-workspace = 3;
        "Mod+CTRL+4".action.move-column-to-workspace = 4;
        "Mod+CTRL+5".action.move-column-to-workspace = 5;
        "Mod+CTRL+6".action.move-column-to-workspace = 6;
        "Mod+CTRL+7".action.move-column-to-workspace = 7;
        "Mod+CTRL+8".action.move-column-to-workspace = 8;
        "Mod+CTRL+9".action.move-column-to-workspace = 9;

        "Mod+TAB".action.focus-workspace-previous = [ ];

        # ─── Layout Controls ───
        "Mod+CTRL+F".action.expand-column-to-available-width = [ ];
        "Mod+C".action.center-column = [ ];
        "Mod+CTRL+C".action.center-visible-columns = [ ];
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        # ─── Modes ───
        "Mod+T".action.toggle-window-floating = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];
        "Mod+W".action.toggle-column-tabbed-display = [ ];
        "Mod+M".action.maximize-window-to-edges = [ ];

        # ─── Screenshots ───
        "Print".action.screenshot = [ ];
        "Ctrl+Print".action.screenshot-screen = [ ];
        "Alt+Print".action.screenshot-window = [ ];
        "CTRL+Shift+1".action.screenshot = [ ];
        "CTRL+Shift+2".action.screenshot-screen = [ ];
        "CTRL+Shift+3".action.screenshot-window = [ ];

        # ─── Emergency Escape Key ───
        # Use this when a fullscreen app blocks your keybinds.
        # It disables any active keyboard shortcut inhibitor, restoring control.
        "Mod+ESCAPE" = {
          allow-inhibiting = false;
          action.toggle-keyboard-shortcuts-inhibit = [ ];
        };

        # ─── Exit / Power ───
        # Also quits Niri
        "CTRL+ALT+Delete".action.quit = [ ];
        # Turn off screens (useful for OLED or privacy)
        "Mod+Shift+P".action.power-off-monitors = [ ];
        "Mod+O" = {
          repeat = false;
          action.toggle-overview = [ ];
        };
      };

      # ────────────── Window Rules ──────────────
      # https://github.com/YaLTeR/niri/wiki/Configuration:-Window-Rules
      window-rules = [
        # Set every window radius to 8
        {
          geometry-corner-radius = {
            top-left = 8.0;
            top-right = 8.0;
            bottom-right = 8.0;
            bottom-left = 8.0;
          };
          clip-to-geometry = true;
        }

        # # Floating Noctalia settings window
        # {
        #   matches = [ { app-id = "dev.noctalia.Noctalia"; } ];
        #   open-floating = true;
        #   default-column-width.fixed = 1080;
        #   default-window-height.fixed = 920;
        # }

        # If you use steam you will probably like these
        {
          matches = [ { app-id = "steam"; } ];
          excludes = [ { title = "^[Ss]team$"; } ];
          open-floating = true;
        }
        {
          matches = [
            {
              app-id = "steam";
              title = "^notificationtoasts_\\d+_desktop$";
            }
          ];
          default-floating-position = {
            x = 10;
            y = 10;
            relative-to = "bottom-right";
          };
          open-focused = false;
        }
      ];

      # ────────────── Layer Rules ──────────────
      # https://github.com/YaLTeR/niri/wiki/Configuration:-Layer-Rules
      layer-rules = [
        {
          matches = [ { namespace = "^noctalia-backdrop"; } ];
          place-within-backdrop = true;
        }
        # {
        #   matches = [ { namespace = "^noctalia-wallpaper"; } ];
        #   place-within-backdrop = true;
        # }
      ];

      # ────────────── Miscellaneous ──────────────
      prefer-no-csd = true;
      screenshot-path = null;

      # switch-events = {
      #   lid-close = [{
      #     spawn = ["noctalia" "msg" "session" "lock-and-suspend"];
      #   }];
      # };

      environment = {
        QT_QPA_PLATFORM = "wayland";
        QT_QPA_PLATFORMTHEME = "qt6ct";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";

        ELECTRON_OZONE_PLATFORM_HINT = "wayland";

        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_TYPE = "wayland";

        DMS_DISABLE_POLKIT = "1";
      };

      cursor = {
        theme = "Qogir";
        size = 24;
      };

      debug = {
        # Allows notification actions and window activation from Noctalia
        honor-xdg-activation-with-invalid-serial = [ ];
      };

      hotkey-overlay = {
        skip-at-startup = true;
      };
    };

    # niri-flake's settings schema doesn't support `background-effect` or
    # `include` yet, so append those nodes directly to the generated config.kdl.
    # (mkOptionDefault merges at the same priority as the option default,
    # concatenating this document with the settings-derived one.)
    config = lib.mkOptionDefault [
      {
        name = "window-rule";
        children = [
          {
            name = "background-effect";
            children = [
              {
                name = "blur";
                arguments = [ true ];
              }
              {
                name = "xray";
                arguments = [ false ];
              }
            ];
          }
        ];
      }

      # noctalia-shell manages this file at runtime (theming etc.).
      # optional=true since the file is missing during build-time `niri validate`
      # (sandboxed, no home dir) and before noctalia first writes it.
      {
        name = "include";
        properties.optional = true;
        arguments = [ "~/.config/niri/noctalia.kdl" ];
      }
    ];
  };

  programs.noctalia = {
    enable = true;

    settings = {
      shell.polkit_agent = true;
    };
  };
}
