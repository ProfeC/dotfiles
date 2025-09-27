# modules/browsers/vivaldi.nix
{ pkgs, ... }:

{
  ########################################
  ## System-wide packages (Stage 1: now)
  ########################################
  environment.systemPackages = [
    pkgs.vivaldi
    pkgs.vivaldi-ffmpeg-codecs
  ];
}
