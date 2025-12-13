# steam.nix
{
  config,
  pkgs,
  ...
}: {
  # Enable the gaming service
  environment.systemPackages = with pkgs; [
    (retroarch.override {
      cores = with libretro; [ # decide what emulators you want to include
        bsnes # Super Nintendo
        directxbox # XBox
        dolphin # Nintendo Gamecube
        dosbox
        duckstation # Playstation
        fbneo # Final Burn Neo - Arcade
        genesisplusgx # Sega Genesis
        mame2016 # Arcade, console, & various
        mesen # Nintendo Entertainment System
        mgba # Nintendo Game Boy Advance
        puae # Amiga 500
        scummvm # Game engine fork the ScummBM adventure game engine.
        stella2014 # Atari 2600
      ];
    })
  ];
}
