{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.myNano;
in
{
  options.myNano = {
    enable = mkEnableOption "Enable customized nano editor";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nano
      nanorc          # provides syntax highlighting files
      ranger          # optional file browser
      lf              # optional file browser
    ];

    environment.etc."nanorc".text = ''
      ## General usability
      set linenumbers       # show line numbers
      set softwrap          # wrap long lines
      set morespace         # remove blank line at bottom
      set smooth            # smooth scrolling
      set mouse             # mouse support
      set indicator         # scrollbar-like indicator

      ## Colors & themes
      set titlecolor white,blue
      set statuscolor brightwhite,magenta
      set selectedcolor black,yellow
      set stripecolor ,green
      set spotlightcolor black,cyan
      set errorcolor white,red
      set functioncolor white,cyan

      ## Highlight current line
      set highlightcolor ,yellow

      ## Backups
      set backup

      ## Syntax highlighting
      include "${pkgs.nanorc}/share/nano/*.nanorc"
    '';
  };
}
