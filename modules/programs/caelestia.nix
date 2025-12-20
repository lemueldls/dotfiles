{
  pkgs,
  config,
  inputs,
  ...
}:
{
  programs.caelestia = {
    enable = true;
    package = config.lib.pamShim.replacePam (
      inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli.overrideAttrs (
        finalAttrs: previousAttrs: {
          prePatch = ''
            substituteInPlace shell.qml \
              --replace-fail 'ShellRoot {' 'ShellRoot {  settings.watchFiles: false'
          '';
        }
      )
    );
    settings = {
      appearance = {
        font.family = {
          sans = "Iosevka Book";
          mono = "Iosevka Code";
          clock = "Iosevka Book";
        };
        transparency.enabled = true;
      };
      general = {
        apps.termial = [
          "wezterm"
          "foot"
        ];
        idle = {
          timeouts = [
            {
              timeout = 300;
              idleAction = "lock";
            }
            {
              timeout = 600;
              idleAction = "dpms off";
              returnAction = "dpms on";
            }
            {
              timeout = 900;
              idleAction = [
                "systemctl"
                "suspend-then-hibernate"
              ];
            }
          ];
        };
      };
      background = {
        desktopClock.enabled = true;
        visualiser = {
          enabled = true;
          blur = true;
        };
      };
      bar = {
        status.showAudio = true;
        sizes.batteryWidth = 320;
        workspaces = {
          shown = 5;
          # occupiedBg = true;
          # activeTrail = true;
          perMonitorWorkspaces = true;
          label = "";
          occupiedLabel = "";
          activeLabel = "";
        };
      };
      launcher = {
        actionPrefix = "/";
        enableDangerousActions = true;
        # useFuzzy.apps = true;
      };
      notifs.actionOnClick = true;
      osd = {
        enableMicrophone = true;
      };
      session = { };
      lock = {
        recolourLogo = true;
      };
      # utilities = {
      #   vpn = {
      #     enable = true;
      #     provider = [ "wgcf" ];
      #   };
      # };
      # services = {
      #   defaultPlayer = "YT Music";
      # };
      paths = {
        sessionGif = "/home/lemuel/session.gif";
      };
    };
    cli = {
      enable = true;
      # package = config.lib.nixGL.wrap caelestia-cli.packages.x86_64-linux.default;
    };
  };
}
