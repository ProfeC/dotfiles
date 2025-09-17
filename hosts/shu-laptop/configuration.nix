{ config, pkgs, ... }:

{
  imports =
    [ 
      # Include the results of the hardware scan.
      #./hardware-configuration.nix

      inputs.hardware.nixosModules.lenovo-thinkpad-t14s
      inputs.hardware.nixosModules.lenovo-thinkpad-t14s
    ];

  # Bootloader
  boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" "thinkpad_acpi" ];
  boot.initrd.kernelModules = [ "acpi_call" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

  networking.hostName = "shu-t14s-nixos";
  hardware.enableAllFirmware = true;

  # Power management
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;

  # Libinput input tuning
  services.libinput.enable = true;
  services.libinput.touchpad.tapping = true;
  services.libinput.touchpad.naturalScrolling = true;
  services.libinput.touchpad.disableWhileTyping = true;
  services.libinput.touchpad.accelProfile = "adaptive";
  services.libinput.touchpad.accelSpeed = "0.5";

  # services.libinput.touchpad.palmdDetection = true;
  # services.libinput.touchscreen.option = ''{
  #       "CalibrationMatrix" = "1 0 0 0 1 0 0 0 1";
  #     };'';


  # services.xserver.inputClassSections = [
  #   {
  #     identifier = "touchpad";
  #     matchIsTouchpad = true;
  #     option = {
  #       "Tapping" = "on";
  #       "NaturalScrolling" = "on";
  #       "PalmDetection" = "on";
  #       "DisableWhileTyping" = "on";
  #       "AccelProfile" = "adaptive";
  #       "AccelSpeed" = "0.5";
  #     };
  #   }
  #   {
  #     identifier = "touchscreen";
  #     matchIsTouchscreen = true;
  #     option = {
  #       "CalibrationMatrix" = "1 0 0 0 1 0 0 0 1";
  #     };
  #   }
  # ];

  # Firmware for fingerprint reader
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;
  
  programs.dconf.enable = true;
}

# Resources
# https://www.joseferben.com/posts/thinkpad_t14_with_nixos_and_i3wm
