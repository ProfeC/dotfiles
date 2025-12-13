# steam.nix
{
  config,
  pkgs,
  ...
}: {
  # Enable the Steam service
  environment.systemPackages = with pkgs; [
    steam
    steam-rom-manager # App for adding 3rd party games/ROMS as Steam launch items.
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
