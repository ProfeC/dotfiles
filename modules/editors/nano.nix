{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.editors.nano;
in
{
  options.editors.nano = {
    enable = mkEnableOption "Enable customized nano editor";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nano
      git
      ranger  # optional file browser
      lf      # optional file browser
    ];

    environment.etc."nanorc".text = ''
      ## Basic usability
      set linenumbers       # show line numbers
      set softwrap          # wrap long lines
      set mouse             # enable mouse support
      set indicator          # visual scroll indicator
      set backup             # keep backups

      ## Earth-tone color palette
      set titlecolor brightwhite,black
      set statuscolor white,green
      set selectedcolor black,brightgreen
      set stripecolor ,brown
      set functioncolor brightcyan,black
      set errorcolor brightwhite,red
      set numbercolor brightyellow,black

      ## Syntax highlighting (fallback definitions)
      ## JSON
      syntax "json" "\.json$"
      color brightgreen  "\{|\}"
      color brightcyan   "\[|\]"
      color yellow       "\"[^\"]*\"(?=\s*:)"
      color magenta      ":[ ]*[0-9]+"
      color brightblue   ":[ ]*\"[^\"]*\""

      ## Markdown
      syntax "markdown" "\.(md|markdown)$"
      color brightcyan  "^#.*"
      color green       "\*\*.*\*\*"
      color magenta     "_.*_"
      color yellow      "`.*`"

      ## Nix
      syntax "nix" "\.nix$"
      color brightcyan   "let|in|rec|with|if|then|else"
      color brightgreen  "[a-zA-Z_][a-zA-Z0-9_]*\s*="
      color yellow       "\".*\""
      color magenta      "[0-9]+"

      ## Try loading system-wide syntax files if present
      include "${pkgs.nano}/share/nano/*.nanorc"
    '';
  };
}
