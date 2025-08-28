{ config, inputs, pkgs, ... }:

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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable Nix User Repo - Use with care!
  # nixpkgs = {
  #   overlays = [
  #     inputs.nur.overlays.default
  #   ];
  # };

  # Basic tools
  environment.systemPackages = with pkgs; [
    btop
    coreutils
    curl
    git
    nano
    neovim
    rsync
    tree
    # vim
    vimPlugins.vim-plug 
    wget
  ];

  # Set the default editor to Nano
  environment.variables.EDITOR = "nano";

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

  # Enable SSH
  # services.openssh.enable = true;

  # # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.lee = {
  #   isNormalUser = true;
  #   description = "Lee";
  #   extraGroups = [ "networkmanager" "wheel" ];
  #   packages = with pkgs; [
  #     kdePackages.kate
  #   #  thunderbird
  #   ];
  # };



}
