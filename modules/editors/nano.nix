{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.editor.nano;
in
{
  options.editor.nano = {
    enable = mkEnableOption "Enable customized nano editor";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nano
      git
      ranger  # optional file browser
      lf      # optional file browser
    ];
  };
}
