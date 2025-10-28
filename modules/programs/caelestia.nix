{
  config,
  caelestia-cli,
  caelestia-shell,
  ...
}:
{
  programs.caelestia = {
    enable = true;
    package = config.lib.nixGL.wrap caelestia-shell.packages.x86_64-linux.default;
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
      };
      background = {
        desktopClock.enabled = true;
      };
      bar = {
        status.showAudio = true;
        sizes.batteryWidth = 320;
      };
      launcher = {
        actionPrefix = "/";
        enableDangerousActions = true;
        # useFuzzy.apps = true;
      };
      notifs.actionOnClick = true;
    };
    cli = {
      enable = true;
      package = config.lib.nixGL.wrap caelestia-cli.packages.x86_64-linux.default;
    };
  };
}
