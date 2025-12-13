# steam.nix
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules/browsers/steam.nix
  ];
  # Enable the gaming service
  environment.systemPackages = with pkgs; [
    cmake # Cross-platform, open-source build system generator
    heroic # Game launcher
    lutris # Games launcher
    mangohud # In game stats HUD overlay
    protonup # GloriousEggroll’s proton fork, ProtonGE.
  ];

  # Other configurations to optimize Steam
  # services.xserver.videoDrivers = [ "nvidia" ];  # or "intel", "amd", etc.
  hardware.graphics.enable = true;
  hardware.xone.enable = true;

  # Configure settings for running Steam
  users.users.lee = {
    extraGroups = [ "games" ];
  };

  programs.gamemode.enable = true;
}
