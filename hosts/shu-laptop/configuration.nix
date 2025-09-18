{ config, pkgs, lib, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader & kernel
  boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" "thinkpad_acpi" ];
  boot.initrd.kernelModules = [ "acpi_call" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  boot.supportedFilesystems = [ "btrfs" "ext4" "vfat" "ntfs" ];

  networking.networkmanager.enable = true;
  networking.hostName = "shu-t14s-nixos";

  hardware.enableAllFirmware = true;

  # Power management
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;

  # Libinput touchpad
  services.libinput.enable = true;
  services.libinput.touchpad.tapping = true;
  services.libinput.touchpad.naturalScrolling = true;
  services.libinput.touchpad.disableWhileTyping = true;
  services.libinput.touchpad.accelProfile = "adaptive";
  services.libinput.touchpad.accelSpeed = 0.5;

  # Fingerprint reader
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;

  # dconf
  programs.dconf.enable = true;
}
