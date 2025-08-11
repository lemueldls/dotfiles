{ pkgs, ... }: {
  home.packages = with pkgs;
    let
      iosevka = callPackage ./fonts/iosevka.nix { };
    in [
        # libre-baskerville
        iosevka.book
        iosevka.code
        (callPackage ./fonts/nerd-font-patch.nix { } iosevka.term)
        # (nerdfonts.override { fonts = [ iosevka.term ]; })
        # recursive
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        # symbola
    ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "Iosevka Book"
        "Noto Sans CJK SC"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Iosevka Book"
        "Noto Sans CJK SC"
        "Noto Color Emoji"
      ];
      monospace = [
        "Iosevka Code"
        "Noto Sans Mono CJK SC"
        "Noto Color Emoji"
      ];
    };
  };
}
