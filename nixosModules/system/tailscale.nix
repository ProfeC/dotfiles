# modules/system/tailscale.nix
{
  config,
  pkgs,
  ...
}: {
  # Enable Tailscale
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";
}
