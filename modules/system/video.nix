# /modules/system/video.nix
{ config, pkgs, ... }:

{
  # Enable OpenGL support
  hardware.opengl {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

}
