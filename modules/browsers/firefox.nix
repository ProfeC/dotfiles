# modules/browsers/firefox.nix
{ pkgs, ... }:

{
  ########################################
  ## System-wide packages (Stage 1: now)
  ########################################
  environment.systemPackages = [
    pkgs.firefox
  ];
}