# modules/desktops/niri/sessions.nix
{ pkgs, ... }:

let
  mkNiriSession =
    { name
    , sessionName
    , comment
    , profile
    }:
    pkgs.stdenv.mkDerivation {
      pname = "niri-${profile}-session";
      version = "1.0.1";

      dontUnpack = true;

      installPhase = ''
        mkdir -p $out/share/wayland-sessions
        cat > $out/share/wayland-sessions/${sessionName}.desktop <<EOF
        [Desktop Entry]
        Name=${name}
        Comment=${comment}
        Exec=niri --config %h/.config/niri/${profile}.kdl
        Type=Application
        EOF
      '';

      passthru.providedSessions = [ sessionName ];
    };
in {
  services.displayManager.sessionPackages = [
    (mkNiriSession {
      name = "Niri (Base)";
      sessionName = "niri-base";
      comment = "Niri + Waybar + Fuzzel";
      profile = "base";
    })

    (mkNiriSession {
      name = "Niri (DankMaterialShell)";
      sessionName = "niri-dms";
      comment = "Niri + DankMaterialShell";
      profile = "dms";
    })

    (mkNiriSession {
      name = "Niri (Noctalia)";
      sessionName = "niri-noctalia";
      comment = "Niri + Noctalia Shell";
      profile = "noctalia";
    })
  ];
}
