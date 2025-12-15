# modules/home/lee/desktops/niri/profile-nocalia.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    noctalia
  ];

  systemd.user.services.noctalia = {
    Unit.Description = "Noctalia Shell";
    Service.ExecStart = "${pkgs.noctalia}/bin/noctalia";
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
