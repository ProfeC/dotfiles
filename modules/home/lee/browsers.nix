{ pkgs, ... }:

{
  home.packages = [ 
    pkgs.brave 
    pkgs.vivaldi 
  ];

  programs.bash.shellAliases = {
    brave-work = "brave --user-data-dir=$HOME/.config/brave-work --use-system-theme";
    vivaldi = "vivaldi-tuned";
  };

  home.file."xdg/brave/policies/managed/extensions.json".text = ''
    { "ExtensionInstallForcelist": ["nngceckbapebfimnlniiiahkandclblb", "bfidboloedlamgdmenmlbipfnccokknp"] }
  '';
}
