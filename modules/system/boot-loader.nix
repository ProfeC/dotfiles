{ config, pkgs, ... }:

{
  # Basic boot settings for portability
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Generic hardware support
  boot.initrd.availableKernelModules = [
    "ahci" "ehci_pci" "firewire_ohci" "ohci_pci" "sd_mod" "sdhci_pci" "sr_mod" "usb_storage" "usbhid" "xhci_pci"
  ];

  boot.supportedFilesystems = [ "btrfs" "ext4" "vfat" "ntfs" ];
  networking.networkmanager.enable = true;
}
