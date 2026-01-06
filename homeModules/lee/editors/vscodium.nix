# modules/home/lee/vscodium.nix
{
  config,
  pkgs,
  lib,
  ...
}: let
  # Extensions available in nixpkgs
  nixpkgsExtensions = with pkgs.vscode-extensions; [
    editorconfig.editorconfig
    esbenp.prettier-vscode
    formulahendry.auto-close-tag
    jnoortheen.nix-ide
    meganrogge.template-string-converter
    mikestead.dotenv
    mkhl.direnv
    naumovs.color-highlight
    oderwat.indent-rainbow
    redhat.vscode-yaml
    tamasfe.even-better-toml
    usernamehw.errorlens
    yzhang.markdown-all-in-one
  ];

  # Extensions only in Marketplace
  marketplaceExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "live-server";
      publisher = "ms-vscode";
      version = "0.4.4"; # update as needed
      sha256 = "1z3dwcq9pdrp6w0jx1cq66v3945p382isqv511znclfxh2jflxiw";
    }
    {
      name = "vscodeintellicode";
      publisher = "VisualStudioExptTeam";
      version = "1.2.30"; # update as needed
      sha256 = "0lg298047vmy31fnkczgpw78k3yxzpiip0ln1wixy70hdpwsfqbz";
    }
  ];
in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    # Merge both extension sources
    profiles.default.extensions = nixpkgsExtensions ++ marketplaceExtensions;

    profiles.default.userSettings = {
      "editor.bracketPairColorization.enabled" = true;
      "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
      "editor.codeActionsOnSave"."source.fixAll" = "always";
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 13;
      "editor.fontWeight" = "500";
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;
      "editor.guides.bracketPairs" = "active";
      "editor.guides.bracketPairsHorizontal" = "active";
      "editor.guides.indentation" = true;
      "editor.inlayHints.enabled" = "on";
      "editor.inlineSuggest.enabled" = true;
      "editor.lineNumbers" = "on";
      "editor.wordWrap" = "on";
      "files.autoSave" = "onWindowChange";
      "files.insertFinalNewline" = true;
      "files.trimTrailingWhitespace" = true;
      "telemetry.telemetryLevel" = "off";
      "workbench.colorTheme" = "Default Dark+";

      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nil}/bin/nil";
      "nix.serverSettings"."nil"."formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];
    };

    profiles.default.keybindings = [
      {
        key = "ctrl+`";
        command = "workbench.action.terminal.focus";
        when = "editorTextFocus";
      }
      {
        key = "ctrl+`";
        command = "workbench.action.focusActiveEditorGroup";
        when = "terminalFocus";
      }
      {
        key = "alt+f";
        command = "editor.action.formatDocument";
        when = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
      }
    ];
  };
}
