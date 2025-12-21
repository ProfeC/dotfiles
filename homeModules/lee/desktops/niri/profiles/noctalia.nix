# modules/home/lee/desktops/niri/profile-nocalia.nix
{ pkgs, inputs, ... }:
let
  noctaliaPkg = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  home.packages = [ noctaliaPkg ];

  programs.waybar.enable = false;
  # optionally disable mako later
}
