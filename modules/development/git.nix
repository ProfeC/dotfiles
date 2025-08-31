# git.nix => Generic git configs
{ config, pkgs, ... }:

{
  config = {
    programs.git = {
      enable = true;
#      prompt = true;
      userName = "G. L. Clark, II";
      userEmail = "gclark2@gmail.com";
#      extraConfig = {
#        init.defaultBranch = "main";
#        safe.directory = "/etc/nixos";
#      };
    };
  };
}
