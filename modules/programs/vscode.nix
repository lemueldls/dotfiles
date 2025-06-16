{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    # package = (config.lib.nixGL.wrap pkgs.vscode);
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # alexdauenhauer.catppuccin-noctis
        # alexdauenhauer.catppuccin-noctis-icons
        bradlc.vscode-tailwindcss
        dbaeumer.vscode-eslint
        eamodio.gitlens
        fill-labs.dependi
        # ms-vscode.atom-keybindings
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        vue.volar
      ];
      keybindings = [
        {
          key = "ctrl+alt+down";
          command = "workbench.action.toggleMaximizedPanel";
        }
      ];
      userSettings = {
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "window.commandCenter" = true;
        "catppuccin-noctis-icons.hidesExplorerArrows" = false;
        "workbench.colorTheme" = "Catppuccin Noctis Mocha";
        "workbench.iconTheme" = "catppuccin noctis icons";
        "workbench.sideBar.location" = "right";
        "workbench.startupEditor" =  "none";
        "explorer.fileNesting.enabled" = true;
        "explorer.fileNesting.expand" = false;
        "editor.tabSize" = 2;
        "editor.fontFamily" = "'Iosevka Code', 'Noto Sans Mono CJK SC', monospace";
        "editor.semanticHighlighting.enabled" = true;
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.codeActionsOnSave" = { "source.fixAll.eslint" = "always"; };
        "editor.gotoLocation.multipleDefinitions" = "goto";
        "terminal.integrated.fontFamily" = "'Iosevka Term', 'Noto Sans Mono CJK SC', monospace";
        "terminal.integrated.defaultProfile.linux" = "fish";
        "terminal.integrated.enableImages" = true;
        "terminal.integrated.profiles.linux" = {
          "bash" = {
            "path" = "bash";
            "icon" = "terminal-bash";
          };
          "zsh" = {
            "path" = "zsh";
          };
          "fish" = {
            "path" = "fish";
          };
          "tmux" = {
            "path" = "tmux";
            "icon" = "terminal-tmux";
          };
          "pwsh" = {
            "path" = "pwsh";
            "icon" = "terminal-powershell";
          };
          "nu" = {
            "path" = "nu";
          };
        };
        "evenBetterToml.semanticTokens" = true;
        "rust-analyzer.semanticHighlighting.operator.specialization.enable" = true;
        "rust-analyzer.semanticHighlighting.punctuation.enable" = true;
        "rust-analyzer.semanticHighlighting.punctuation.specialization.enable" = true;
        "rust-analyzer.semanticHighlighting.punctuation.separate.macro.bang" = true;
        "cSpell.diagnosticLevel" = "Hint";
        "evenBetterToml.formatter.arrayAutoCollapse" = true;
        "evenBetterToml.formatter.allowedBlankLines" = 1;
        "evenBetterToml.formatter.arrayAutoExpand" = true;
        "evenBetterToml.formatter.arrayTrailingComma" = true;
        "evenBetterToml.formatter.reorderArrays" = true;
        "evenBetterToml.formatter.reorderInlineTables" = true;
        "evenBetterToml.formatter.reorderKeys" = true;
        "evenBetterToml.formatter.trailingNewline" = true;
        "evenBetterToml.schema.links" = true;
        "files.associations" = {
          "*.json" = "jsonc";
        };
        "tailwindCSS.experimental.classRegex" = [
          [ "([\"'`][^\"'`]*.*?[\"'`])" "[\"'`]([^\"'`]*).*?[\"'`]" ]
        ];
        "[json]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[jsonc]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[yaml]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[html]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[markdown]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[javascript]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[javascriptreact]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[typescript]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[typescriptreact]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[css]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[scss]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[less]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[vue]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[rust]" = { "editor.defaultFormatter" = "rust-lang.rust-analyzer"; };
      };
    };
  };
}
