# homeModules/common/gui-apps.nix
{
  config,
  pkgs,
  ...
}: {
  # imports = [  ];

  # Add launchers and "stuff".
  home.packages = with pkgs; [
    filezilla
    kdePackages.kate
    libreoffice-fresh
    obsidian
  ];
}
