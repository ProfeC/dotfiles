# Configuration for Mac Mini (2014) 16GB Ram 1TB HD

{ config, pkgs, ... }:

{
  networking.hostName = "macmini-nixos"; # Define your hostname.

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/8ff73aa1-74f3-4f44-bc19-116a6955c0bc";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/67E3-17ED";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  services.openssh.enable = true; # Enable SSH access
  
}
