{ ... }:
{
  imports = [
    ./fonts
    ./programs
  ];

  programs.plasma = {
    enable = true;
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "teal";
  };
}
