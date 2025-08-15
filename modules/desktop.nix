{ ... }:
{
  imports = [
    ./fonts
    ./programs
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "teal";

    vscode.enable = false;
  };
}
