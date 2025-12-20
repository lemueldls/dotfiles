{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    let
      iosevka = callPackage ./iosevka.nix { };
    in
    [
      # libre-baskerville
      (callPackage ./nerd-font-patch.nix { } iosevka.book)
      (callPackage ./nerd-font-patch.nix { } iosevka.code)
      (callPackage ./nerd-font-patch.nix { } iosevka.term)
      nerd-fonts.symbols-only
      # recursive
      sarasa-gothic
      noto-fonts-color-emoji
      material-symbols
      # symbola
    ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "Iosevka Book"
        "Sarasa Gothic SC"
        "Sarasa Gothic J"
        "Sarasa Gothic K"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Iosevka Book"
        "Sarasa Gothic SC"
        "Sarasa Gothic J"
        "Sarasa Gothic K"
        "Noto Color Emoji"
      ];
      monospace = [
        "Iosevka Code"
        "Sarasa Mono SC"
        "Sarasa Mono J"
        "Sarasa Mono K"
        "Noto Color Emoji"
      ];
    };
  };
}
