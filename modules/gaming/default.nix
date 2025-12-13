# steam.nix
{
  config,
  pkgs,
  ...
}: {
  # Enable the Steam service
  environment.systemPackages = with pkgs; [
    cmake # Cross-platform, open-source build system generator
  ];

  # Other configurations to optimize Steam
  # services.xserver.videoDrivers = [ "nvidia" ];  # or "intel", "amd", etc.
  hardware.graphics.enable = true;
  hardware.xone.enable = true;

  # Configure settings for running Steam
  users.users.lee = {
    extraGroups = [ "games" ];
  };
}
