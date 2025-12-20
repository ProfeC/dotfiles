# homeModules/common/browsers.nix
{
  config,
  pkgs,
  ...
}: {
  # imports = [  ];

  # Add launchers and "stuff".
  home.packages = with pkgs; [
    brave
    firefox
    vivaldi
    vivaldi-ffmpeg-codecs
  ];
}
