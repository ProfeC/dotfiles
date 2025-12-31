# modules/desktops/niri/sessions.nix
{ pkgs, ... }:

{
  services.displayManager.sessionPackages = [
    (pkgs.stdenv.mkDerivation {
      pname = "niri-session";
      version = "1.0";
      dontUnpack = true;

      installPhase = ''
        mkdir -p $out/share/wayland-sessions
        cat > $out/share/wayland-sessions/niri.desktop << EOF
        [Desktop Entry]
        Name=Niri
        Comment=Niri Wayland Compositor
        Exec=niri
        Type=Application
        EOF
      '';

      passthru.providedSessions = [ "niri" ];
    })
  ];
}
