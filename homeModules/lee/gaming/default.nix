# homeModules/lee/gaming/default.nix
# nixosModules/gaming/default.nix
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./minecraft.nix
  ];
  # Enable the gaming service
  home.packages = with pkgs; [
    heroic # Game launcher
    lutris # Games launcher
    mangohud # In game stats HUD overlay
  ];
}
