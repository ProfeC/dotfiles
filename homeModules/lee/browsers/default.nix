# homeModules/lee/browsers/default.nix
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../common/browsers.nix
    # ./brave.nix
    # ./firefox.nix
    ./vivaldi.nix
  ];

}
