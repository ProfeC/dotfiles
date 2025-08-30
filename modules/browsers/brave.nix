# brave.nix
{ pkgs, ... }:

{
  ## Install Brave
  environment.systemPackages = with pkgs; [ brave ];

  ## Force‑install Bitwarden + PureVPN extensions
  environment.etc."opt/brave/policies/managed/extensions.json".text = ''
    {
      "ExtensionInstallForcelist": [
        "nngceckbapebfimnlniiiahkandclblb",  // Bitwarden - https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb
        "bfidboloedlamgdmenmlbipfnccokknp"   // PureVPN - https://chromewebstore.google.com/detail/purevpn-proxy-best-vpn-fo/bfidboloedlamgdmenmlbipfnccokknp
      ]
    }
  '';

  ## Optional wrapper to always “follow system” theme
  environment.etc."xdg/brave-wrapper.sh".text = ''
    #!/usr/bin/env bash
    exec ${pkgs.brave}/bin/brave --enable-features=WebUIDarkMode --use-system-theme "$@"
  '';

  ## Handy aliases for separate work/home profiles
  programs.bash.shellAliases = {
    brave-work = "brave --user-data-dir=$HOME/.config/brave-work --use-system-theme";
    brave-home = "brave --user-data-dir=$HOME/.config/brave-home --use-system-theme";
  };
}
