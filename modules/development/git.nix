# git.nix => Generic git configs
{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "G. L. Clark, II";
    userEmail = "gclark2@gmail.com";
    # extraConfig = {
    #   init.defaultBranch = "main";
    #   safe.directory = "/etc/nixos";
    # };
  };

  programs.ssh = {
    enable = true;
    # Use ssh-agent managed by systemd
    startAgent = true;
  };
}
