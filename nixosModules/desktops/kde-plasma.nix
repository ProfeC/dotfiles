{ config, pkgs, ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Add some KDE Plasma programs.
  # programs.partition-manager.enable = true;

  # Add some system packages; ref: https://nixos.wiki/wiki/KDE#Contemporary_Setup
  environment.systemPackages = with pkgs; [
    kdePackages.isoimagewriter # Program to write hybrid ISO files to USB disks
    kdePackages.ksystemlog # KDE system log application
    kdePackages.partitionmanager # Manage disk devices, partitions, etc.
    kdePackages.sddm-kcm # Configuration module for SDDM
    wayland-utils # Wayland utilities
    wl-clipboard # CLI copy and paste utilities for Wayland
    xclip # Tool to access the X clipboard from a console application
  ];

}
