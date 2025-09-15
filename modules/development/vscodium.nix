# vscodium.nix => Config for VSCode/VSCodium
{ config, pkgs, lib, ... }:

let
  vscodiumExtensions = with pkgs.vscode-extensions; [
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
    ms-vscode.live-server
    visualstudioexptteam.vscodeintellicode
    # alefragnani.project-manager
    # astro-build.astro-vscode
    # leonardssh.vscord
    # bradlc.vscode-tailwindcss
    # christian-kohler.npm-intellisense
    # christian-kohler.path-intellisense
    # dbaeumer.vscode-eslint
    # eamodio.gitlens
  ];

in {
  options.development.vscodium.enable =
    lib.mkEnableOption "VSCodium with extensions and base settings";

  config = lib.mkIf config.development.vscodium.enable {
    environment.systemPackages = [
      (pkgs.vscode-with-extensions.override {
        vscode = pkgs.vscodium;
        vscodeExtensions = vscodiumExtensions;
      })
    ];

    # Optional: ship global settings.json (all users inherit this)
    environment.etc."vscode/settings.json".text = builtins.toJSON {
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
      "editor.inlayHints.padding" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.lineNumbers" = "on";
      "editor.linkedEditing" = true;
      "editor.minimap.enabled" = true;
      "editor.parameterHints.enabled" = true;
      "editor.scrollbar.horizontal" = "hidden";
      # "editor.scrollbar.vertical" = "hidden";
      "editor.semanticHighlighting.enabled" = true;
      "editor.showUnused" = true;
      "editor.snippetSuggestions" = "top";
      "editor.stickyScroll.enabled" = true;
      "editor.tabCompletion" = "on";
      "editor.tabSize" = 2;
      "editor.trimAutoWhitespace" = true;
      "editor.wordWrap" = "on";
      "editor.wrappingIndent" = "indent";
      "extensions.autoCheckUpdates" = false;
      "extensions.autoUpdate" = false;
      "files.autoSave" = "onWindowChange";
      "files.insertFinalNewline" = true;
      "files.trimTrailingWhitespace" = true;
      "redhat.telemetry.enabled" = false;
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono', 'monospace', monospace";
      "terminal.integrated.fontSize" = 13;
      "terminal.integrated.gpuAcceleration" = "on";
      "terminal.integrated.minimumContrastRatio" = 1;
      "update.mode" = "none";
      "update.showReleaseNotes" = false;
      "window.dialogStyle" = "custom";
      "window.menuBarVisibility" = "toggle";
      "window.titleBarStyle" = "custom";
      "workbench.activityBar.location" = "bottom";
      "workbench.colorTheme" = "Default Dark+";
      "workbench.editor.empty.hint" = "hidden";
      "workbench.editor.showTabs" = "multiple";
      "workbench.layoutControl.enabled" = false;
      "workbench.layoutControl.type" = "menu";
      "workbench.sideBar.location" = "left";
      "workbench.startupEditor" = "none";
      # "workbench.statusBar.visible" = false;
      "workbench.tree.indent" = 16;

      # Formatter Settings
      "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[markdown]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
      "[scss]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";

      # Extension Settings
      # git
      "git.autofetch" = true;
      "git.enableCommitSigning" = true;
      "git.enableSmartCommit" = true;
      "git.openRepositoryInParentFolders" = "always";

      # errorLens
      "errorLens.gutterIconsEnabled" = true;
      "errorLens.gutterIconSet" = "defaultOutline";

      # eslint
      "eslint.format.enable" = true;
      "eslint.problems.shortenToSingleLine" = true;
      "eslint.validate" = [
        "javascript"
        "typescript"
        "javascriptreact"
        "typescriptreact"
      ];

      # prettier
      "prettier.jsxSingleQuote" = true;

      # Language Specific Settings

      # javascript
      "javascript.inlayHints.functionLikeReturnTypes.enabled" = true;
      "javascript.inlayHints.parameterNames.enabled" = "all";
      "javascript.inlayHints.parameterTypes.enabled" = true;
      "javascript.inlayHints.propertyDeclarationTypes.enabled" = true;
      "javascript.preferGoToSourceDefinition" = true;
      "javascript.suggest.completeFunctionCalls" = true;

      # nix
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nil}/bin/nil";
      "nix.serverSettings"."nil"."formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];

      # typescript
      "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;
      "typescript.inlayHints.parameterNames.enabled" = "all";
      "typescript.inlayHints.parameterTypes.enabled" = true;
      "typescript.inlayHints.propertyDeclarationTypes.enabled" = true;
      "typescript.preferGoToSourceDefinition" = true;
      "typescript.suggest.completeFunctionCalls" = true;


    };

    environment.etc."vscode/keybindings.json".text = builtins.toJSON [
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
        when =
          "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
      }
    ];
  };
}
