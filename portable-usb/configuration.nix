# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

let
  host = import ./host.nix;
in {
  imports = (
    [ 
      ./hardware-configuration.nix 
      ./modules/common-desktop.nix 
      ./modules/brave.nix
    ]
    ++ lib.optional (host.deviceModel == "ThinkPad T14s Gen 2i") ./profiles/thinkpad-t14s.nix
    ++ lib.optional (host.deviceModel == "Macmini7,1") ./profiles/macmini-7-1.nix
  );


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable extra file systems
  boot.supportedFilesystems = [ "fuse" ];

  # Enable all hardware.
  hardware.enableAllHardware = true;

  # Enable networking
  lib.mkDefault.networking.hostName = "nixos-default"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Fuse file system
  services.udev.extraRules = ''
    KERNEL=="fuse", MODE="0666"
    KERNEL=="fuse3", MODE="0666"
  '';

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  # Enable Tailscale
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lee = {
    isNormalUser = true;
    description = "Lee";
    extraGroups = [ "networkmanager" "wheel" "fuse" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
#     brave // Installed via modules.
    btop
    coreutils
    curl
    git
    python3Full
    rclone
    vivaldi
    vivaldi-ffmpeg-codecs
    vscodium
    wget

    # w3m-nographics # needed for the manual anyway
    testdisk # useful for repairing boot problems
    ms-sys # for writing Microsoft boot sectors / MBRs
    efibootmgr
    efivar
    parted
    gptfdisk
    ddrescue
    ccrypt
    cryptsetup # needed for dm-crypt volumes

    # Some text editors.
    obsidian
    # vim
    nano

    # Some networking tools.
    fuse
    fuse3
    openconnect
    sshfs-fuse
    socat
    screen
    tcpdump

    # Hardware-related tools.
    sdparm
    hdparm
    smartmontools # for diagnosing hard disks
    pciutils
    usbutils
    nvme-cli

    # Some compression/archiver tools.
    unzip
    zip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
