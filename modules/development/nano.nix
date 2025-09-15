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
      git
      ranger  # optional file browser
      lf      # optional file browser
    ];

    # System-wide Nano configuration
    environment.etc."nanorc".text = ''
      ## Basic usability
      set linenumbers       # show line numbers
      set softwrap          # wrap long lines
      set mouse             # enable mouse support
      set indicator          # visual scroll indicator
      set backup             # keep backups

      ## Warm-ish color palette (matches Onedark Warm feel)
      set titlecolor brightwhite,orange
      set statuscolor brightwhite,brown
      set selectedcolor black,orange
      set stripecolor ,yellow
      set functioncolor brightyellow,red
      set errorcolor brightwhite,red
      set numbercolor brightyellow,blue

      ## Include syntax highlighting if available
      if exist "${pkgs.nano}/share/nano"
        include "${pkgs.nano}/share/nano/*.nanorc"
      endif
    '';
  };
}
