{ config, pkgs, ... }:

{
    imports = [ ./theme.nix ];

    # environment = {
    #     systemPackages = with pkgs; [ ];

    #     sessionVariables.NIXOS_OZONE_WL = "1";
    # };

    fonts = {
        packages = with pkgs;
        let
            iosevka-code = callPackage ./fonts/iosevka-code.nix { };
            iosevka-book = callPackage ./fonts/iosevka-book.nix { };
        in [
            iosevka-code
            iosevka-book
            (callPackage ./fonts/nerd-font-patch.nix { } iosevka-code)
            (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
            noto-fonts
            noto-fonts-color-emoji
            symbola
        ];
        fontconfig = {
            enable = true;
            subpixel.rgba = "rgb";
            localConf = ''
                <alias>
                    <family>monospace</family>
                    <prefer><family>Symbols Nerd Font</family></prefer>
                </alias>
            '';
        };
    };
}
