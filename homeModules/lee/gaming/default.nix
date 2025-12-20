# homeModules/lee/gaming/default.nix
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../homeModules/common/gaming-apps.nix
    ./minecraft.nix
  ];

}
