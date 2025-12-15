# modules/home/lee/desktops/niri/profile-legos.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
    fuzzel
  ];

  programs.waybar.enable = true;
  services.mako.enable = true;

  systemd.user.services.waybar = {
    Unit.Description = "Waybar";
    Service.ExecStart = "${pkgs.waybar}/bin/waybar";
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
