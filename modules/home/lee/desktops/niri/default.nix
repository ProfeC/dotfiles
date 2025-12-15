# modules/home/lee/desktops/niri/default.nix
{ lib, ... }:

let
  profile = builtins.getEnv "NIRI_PROFILE";
in {
  imports =
    [ ./base.nix ]
    ++ lib.optional (profile == "legos") ./profile-legos.nix
    ++ lib.optional (profile == "dms") ./profile-dms.nix
    ++ lib.optional (profile == "noctalia") ./profile-noctalia.nix;
}
