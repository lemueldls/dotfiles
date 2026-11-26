{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.symbols-only
    # recursive
    # sarasa-gothic
    noto-fonts-color-emoji
    material-symbols
    # symbola
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "Asterism Text"
        "Sarasa Gothic SC"
        "Sarasa Gothic J"
        "Sarasa Gothic K"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Asterism Text"
        "Sarasa Gothic SC"
        "Sarasa Gothic J"
        "Sarasa Gothic K"
        "Noto Color Emoji"
      ];
      monospace = [
        "AsterismCode Nerd Font"
        "Sarasa Mono SC"
        "Sarasa Mono J"
        "Sarasa Mono K"
        "Noto Color Emoji"
      ];
    };
  };
}
