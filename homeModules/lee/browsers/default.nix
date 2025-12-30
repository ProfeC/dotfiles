# homeModules/lee/browsers/default.nix
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../common/browsers.nix
    # ./vivaldi.nix
  ];

}
