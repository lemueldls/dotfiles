{
  config,
  caelestia-cli,
  caelestia-shell,
  ...
}:
{
  programs.caelestia = {
    enable = true;
    package = (config.lib.nixGL.wrap caelestia-shell.packages.x86_64-linux.default);
    settings = {
      appearance.font.family = {
        sans = "Iosevak Book";
        mono = "Iosevak Code";
        clock = "Iosevak Book";
      };
      bar.sizes.batteryWidth = 320;
      general.apps.termial = [ "wezterm" ];
      notifs.actionOnClick = true;
    };
    cli = {
      enable = true;
      package = (config.lib.nixGL.wrap caelestia-cli.packages.x86_64-linux.default);
    };
  };
}
