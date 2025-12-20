{
  lib,
  pkgs,
  ...
}:
{
  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      hotkey-overlay = {
        skip-at-startup = true;
      };

      includes = lib.mkMerge [
        (lib.mkAfter [
          "dms/alttab.kdl"
          "dms/binds.kdl"
          "dms/colors.kdl"
          "dms/layout.kdl"
          "dms/wpblur.kdl"
        ])
      ];
    };
  };

  programs.dank-material-shell = {
    enable = true;

    niri = {
      enableKeybinds = true;
      enableSpawn = true;
    };

    default.settings = {
      theme = "dark";
      dynamicTheming = true;
    };

    default.session = {
    };
  };

  # systemd.user.services.niri-flake-polkit.enable = false;
}
