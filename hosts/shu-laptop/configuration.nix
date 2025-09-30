{ config, pkgs, lib, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration-t14s.nix
  ];

  # Bootloader & kernel
  boot.initrd.kernelModules = [ "acpi_call" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

  # --- Bootloader (UEFI) ---
  boot.loader.systemd-boot.enable = true;
  # allow installer / Nix to update the EFI variables
  boot.loader.efi.canTouchEfiVariables = true;

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
  services.libinput.touchpad.accelSpeed = "0.5";

  # Fingerprint reader
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;

  # dconf
  programs.dconf.enable = true;

  # File System Mounts
  fileSystems."/mnt/win11data" = {
    device = "/dev/disk/by-uuid/426AD8096AD7F79D"; # safer than /dev/nvme0n1p3
    fsType = "ntfs3";
    options = [ "rw" "uid=1000" "gid=100" "umask=022" ];
  };
}
