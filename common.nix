{ config, pkgs, ... }:

{
  # Basic boot settings for portability
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # Generic hardware support
  boot.initrd.availableKernelModules = [
    "ahci" "ehci_pci" "firewire_ohci" "ohci_pci" "sd_mod" "sdhci_pci" "sr_mod" "usb_storage" "usbhid" "xhci_pci"
  ];

  boot.supportedFilesystems = [ "btrfs" "ext4" "vfat" "ntfs" ];
  networking.networkmanager.enable = true;

  # Default user
  users.users.lee = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme";
  };

  # Basic tools
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    wget
  ];

  services.openssh.enable = true;
}
