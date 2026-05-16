{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;

    settings = {
      hotkey-overlay = {
        skip-at-startup = true;
      };

      cursor = {
        theme = "Qogir";
        size = 24;
      };

      spawn-at-startup = [
        { command = [ "/usr/lib/polkit-kde-authentication-agent-1" ]; }
      ];

      environment = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";

        DMS_DISABLE_POLKIT = "1";
      };
    };
  };

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;

    niri = {
      enableSpawn = true;
      includes.enable = true;
    };

    dgop.package = inputs.dgop.packages.x86_64-linux.default;
  };
}
