{ pkgs, ... }:

{
  home.packages = with pkgs; [
    niri
    xwayland-satellite
    fuzzel
    # rofi
    swaylock
    alacritty

    # U/X Tools
    brightnessctl # brightness control
    grim # For screenshots
    slurp # For screenshots
    wl-clipboard # clipboard manager?
  ];
}
