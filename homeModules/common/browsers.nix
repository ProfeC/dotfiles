# homeModules/common/browsers.nix
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./browser-extension-bootstrap.nix
  ];

  # Add launchers and "stuff".
  home.packages = with pkgs; [
    brave
    firefox
    vivaldi
    vivaldi-ffmpeg-codecs
  ];
}
