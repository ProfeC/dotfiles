# homeModules/common/gaming-apps.nix
{
  config,
  pkgs,
  ...
}: {
  # imports = [  ];

  # Add launchers and "stuff".
  home.packages = with pkgs; [
    heroic # Game launcher
    lutris # Games launcher
    mangohud # In game stats HUD overlay
    # steam
    # steam.cmd
    steam-rom-manager # App for adding 3rd party games/ROMS as Steam launch items.
  ];
}
