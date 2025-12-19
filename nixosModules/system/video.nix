# /modules/system/video.nix
{ config, pkgs, ... }:

{
  # Ensure graphics support
  hardware.graphics = {
    enable = true;
  };

}
