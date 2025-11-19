{ config, pkgs, lib, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration-t14s-ssd.nix
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
  # Windows Data
  fileSystems."/mnt/win11data" = {
    device = "/dev/disk/by-uuid/426AD8096AD7F79D"; # safer than /dev/nvme0n1p3
    fsType = "ntfs3";
    options = [ "rw" "uid=1000" "gid=100" "umask=022" ];
  };

  # Games
  fileSystems."/mnt/games" = {
    device = "//192.168.13.3/gaming";
    fsType = "cifs";
    options = [
      "credentials=/home/lee/etc/nixos/secrets/.smbcredentials" # Credentials file
      "dir_mode=0775" # Permissions for directories
      "file_mode=0775" # Permissions for files
      "gid=100"
      "iocharset=utf8"
      "noauto" # Only mount when accessed (with automount)
      "nofail"
      "uid=1000"
      "vers=3.0" # SMB version (optional, adjust if needed)
      "x-systemd.automount" # Auto-mount on access (optional, for lazy mounting)
      "x-systemd.device-timeout=5s"
      "x-systemd.idle-timeout=60"
      "x-systemd.mount-timeout=5s"
    ];
  };
}
