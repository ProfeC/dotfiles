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
  ];
}
