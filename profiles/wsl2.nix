# profiles/wsl2.nix
# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    #   # include NixOS-WSL modules
    #   <nixos-wsl/modules>
    # ../hosts/shu-laptop/hardware-configuration-wsl2.nix
    ../modules/default.nix
    # ../modules/development/git.nix
  ];

  editor.nano.enable = true;
  editor.neovim.enable = true;
  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = false; # set to true if you use oh-my-zsh
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ll = "ls -lah";
      lt = "ls -laht";
    };
  };

  wsl = {
    enable = true;
    # defaultUser = "nixos";
    # defaultUser = "clarkgar";
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    startMenuLaunchers = true;
  };

  users.users.nixos = {
    shell = pkgs.zsh;
    # openssh.authorizedKeys.keys = [];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
