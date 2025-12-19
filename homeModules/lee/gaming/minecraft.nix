# prism-launcher.nix
{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    prismlauncher
  ];
}
