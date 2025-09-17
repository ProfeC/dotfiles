{ config, inputs, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set some Nix defaults.
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 13d";
    };

    optimise = {
      automatic = true;
      dates = ["weekly"];
    };

    # Enable the Flakes feature and the accompanying new nix command-line tool
    settings.experimental-features = [ "nix-command" "flakes" ];

  };

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

  # Enable Nix User Repo - Use with care!
  # nixpkgs = {
  #   overlays = [
  #     inputs.nur.overlays.default
  #   ];
  # };

  # Basic tools
  environment.systemPackages = with pkgs; [
    bat
    btop
    coreutils
    curl
    eza
    git
    tree
    wget

    # Some text editors.
    nano
    neovim
    # vim
    vimPlugins.vim-plug

    # Some networking tools.
    openconnect
    rclone
    rsync
    sshfs-fuse
    socat
    screen
    tcpdump

    # Some compression/archiver tools.
    gzip
    unzip
    zip

    # Fonts for previews and such
    nerd-fonts.fira-code
    nerd-fonts.noto
    nerd-fonts.sauce-code-pro
  ];

  # Set the default editor to Neovim
  environment.variables.EDITOR = "nvim";

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
