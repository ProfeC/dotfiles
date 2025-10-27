# steam.nix
{
  config,
  pkgs,
  ...
}: {
  programs.steam = {
    enable = true;
  };
}
