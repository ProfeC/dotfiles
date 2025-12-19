# Fuse File Systems
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fuse
    fuse3
  ];

  # Enable Fuse file system
  services.udev.extraRules = ''
    KERNEL=="fuse", MODE="0666"
    KERNEL=="fuse3", MODE="0666"
  '';

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

}