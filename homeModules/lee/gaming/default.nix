# homeModules/lee/gaming/default.nix
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../common/gaming-apps.nix
    ./minecraft.nix
  ];

}
