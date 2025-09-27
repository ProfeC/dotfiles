# modules/development/git.nix => Generic git configs
{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    # Use ssh-agent managed by systemd
    startAgent = true;
  };
}
