# steam.nix
{
  config,
  pkgs,
  ...
}: {
  # Enable the Steam service
  environment.systemPackages = with pkgs; [
    cmake # Cross-platform, open-source build system generator
    steam
    steam-rom-manager # App for adding 3rd party games/ROMS as Steam launch items.
  ];

  # Other configurations to optimize Steam
  # services.xserver.videoDrivers = [ "nvidia" ];  # or "intel", "amd", etc.
  hardware.graphics.enable = true;
  hardware.xone.enable = true;

  # Configure settings for running Steam
  users.users.lee = {
    extraGroups = [ "games" ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
