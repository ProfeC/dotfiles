# nixosModules/gaming/default.nix
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./steam.nix
<<<<<<< HEAD:nixosModules/gaming/default.nix
=======
    ./retroarch.nix
>>>>>>> 0c630a2 (adds retroarch):modules/gaming/default.nix
  ];
  # Enable the gaming service
  environment.systemPackages = with pkgs; [
    cmake # Cross-platform, open-source build system generator
<<<<<<< HEAD:nixosModules/gaming/default.nix
    protonup-ng # GloriousEggroll’s proton fork, ProtonGE.
=======
    heroic # Game launcher
    lutris # Games launcher
    mangohud # In game stats HUD overlay
    protonup # GloriousEggroll’s proton fork, ProtonGE.
    protonup-qt # GUI for installing custom Proton versions like GE_Proton
>>>>>>> 0c630a2 (adds retroarch):modules/gaming/default.nix
  ];

  # Other configurations to optimize Steam
  # services.xserver.videoDrivers = [ "nvidia" ];  # or "intel", "amd", etc.
  hardware.graphics.enable = true;
  hardware.xone.enable = true;

  programs.gamemode.enable = true;
}
