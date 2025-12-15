# modules/home/lee/desktops/niri/profile-dms.nix
# dms => Dank Material Shell
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dank-material-shell
  ];

  systemd.user.services.dms = {
    Unit.Description = "DankMaterialShell";
    Service.ExecStart = "${pkgs.dank-material-shell}/bin/dms";
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
