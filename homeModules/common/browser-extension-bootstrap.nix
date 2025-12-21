# homeModules/common/browser-extension-bootstrap.nix
{ pkgs, lib, ... }:

let
  # Chromium-family (Brave/Vivaldi/Chrome/Chromium) – Chrome Web Store
  chromiumUrls = [
    "https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb"
    "https://chromewebstore.google.com/detail/purevpn-proxy-best-vpn-fo/bfidboloedlamgdmenmlbipfnccokknp"
  ];

  # Firefox – addons.mozilla.org
  firefoxUrls = [
    "https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/"
    "https://addons.mozilla.org/en-US/firefox/addon/purevpn-for-privacy-security/"
  ];

  script = pkgs.writeShellScriptBin "browser-install-extensions" ''
    set -euo pipefail

    mode="all"
    if [ "''${1-}" = "--chromium" ]; then mode="chromium"; fi
    if [ "''${1-}" = "--firefox" ]; then mode="firefox"; fi

    open_urls() {
      local urls="$1"
      if command -v xdg-open >/dev/null 2>&1; then
        # Open each URL in the default browser
        while IFS= read -r url; do
          [ -n "$url" ] || continue
          xdg-open "$url" >/dev/null 2>&1 || true
          sleep 0.25
        done <<< "$urls"
      else
        echo "xdg-open not found. URLs:"
        printf '%s\n' $urls
      fi
    }

    chromium_list="${lib.concatStringsSep "\n" chromiumUrls}"
    firefox_list="${lib.concatStringsSep "\n" firefoxUrls}"

    case "$mode" in
      chromium) open_urls "$chromium_list" ;;
      firefox)  open_urls "$firefox_list" ;;
      all)
        open_urls "$chromium_list"
        open_urls "$firefox_list"
        ;;
    esac

    echo "Done. Install the extensions in the browser tabs that opened."
  '';
in
{
  home.packages = [ script ];

  # Optional convenience launchers (show up in KDE app launcher/KRunner)
  xdg.desktopEntries = {
    install-extensions-all = {
      name = "Install Browser Extensions (Bitwarden + PureVPN)";
      comment = "Opens extension pages (Chromium + Firefox)";
      exec = "browser-install-extensions";
      terminal = false;
      categories = [ "Utility" ];
    };

    install-extensions-chromium = {
      name = "Install Extensions (Chromium family)";
      comment = "Opens Chrome Web Store pages for Bitwarden + PureVPN";
      exec = "browser-install-extensions --chromium";
      terminal = false;
      categories = [ "Utility" ];
    };

    install-extensions-firefox = {
      name = "Install Extensions (Firefox)";
      comment = "Opens Firefox Add-ons pages for Bitwarden + PureVPN";
      exec = "browser-install-extensions --firefox";
      terminal = false;
      categories = [ "Utility" ];
    };
  };
}
