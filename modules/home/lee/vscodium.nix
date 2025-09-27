# modules/home/lee/vscodium.nix
{ config, pkgs, lib, ... }:

let
  vscodiumExtensions = [
    "editorconfig.editorconfig"
    "esbenp.prettier-vscode"
    "formulahendry.auto-close-tag"
    "jnoortheen.nix-ide"
    "meganrogge.template-string-converter"
    "mikestead.dotenv"
    "mkhl.direnv"
    "naumovs.color-highlight"
    "oderwat.indent-rainbow"
    "redhat.vscode-yaml"
    "tamasfe.even-better-toml"
    "usernamehw.errorlens"
    "yzhang.markdown-all-in-one"
    "ms-vscode.live-server"
    "visualstudioexptteam.vscodeintellicode"
  ];

  extensionInstallScript = pkgs.writeShellScriptBin "install-vscodium-extensions" ''
    #!/usr/bin/env bash
    set -e
    for ext in ${lib.concatStringsSep " " vscodiumExtensions}; do
      codium --install-extension "$ext" || true
    done
  '';
in
{
  options.vscodium.enable = lib.mkEnableOption "Enable VSCodium with extensions and settings for Lee";

  config = lib.mkIf config.vscodium.enable {
    # Install the VSCodium binary
    home.packages = [ pkgs.vscodium ];

    # User settings
    home.file.".config/VSCodium/User/settings.json".text = builtins.toJSON {
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
      "nix.serverSettings"."nil"."formatting"."command" = [ "${pkgs.alejandra}/bin/alejandra" ];
    };

    # Keybindings
    home.file.".config/VSCodium/User/keybindings.json".text = builtins.toJSON [
      { key = "ctrl+`"; command = "workbench.action.terminal.focus"; when = "editorTextFocus"; }
      { key = "ctrl+`"; command = "workbench.action.focusActiveEditorGroup"; when = "terminalFocus"; }
      { key = "alt+f"; command = "editor.action.formatDocument"; when = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor"; }
    ];

    # Wrapper script to install extensions one time
    home.file.".local/bin/install-vscodium-extensions".source = extensionInstallScript;

    # Make the wrapper executable
    home.file.".local/bin/install-vscodium-extensions".executable = true;
  };
}
