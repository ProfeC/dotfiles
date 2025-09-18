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
}:

{
  imports = [
    #   # include NixOS-WSL modules
    #   <nixos-wsl/modules>
    # ../hosts/shu-laptop/hardware-configuration-wsl2.nix
    ../modules/common.nix
    ../modules/browsers/firefox.nix
    ../modules/system/x11.nix
    # ../modules/development/git.nix
    ../modules/editors/nano.nix
    ../modules/editors/neovim.nix
  ];

  editor.nano.enable = true;
  editor.neovim.enable = true;

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
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtmsr35Syy1YILOvsOnsXqUG7gdzz5FWmpiC0TNhD0dbehsamuetfUjlmOTaJzz1US93aBFsVDmE89R7XeWMqUjRzvDYE1RrW6QvDN+pHKOqyzqvoPuJmKE4L9HRpcLKj6Jn8SoFhzRBwu96tgg/99XWEQ8MSgyoGD728CIe9iWqvfJB0Z6wNK72YSGe1sF6JleUNvjmmEumSgIwIcAQ4kzFEowt8m41jhWhhEHz4Yv6LYzHILZmMqpAswzPXdNhkXp4wPnh5fw8BMRZtJnwp2MkpKLik5N6uNi/EtyRU/mW0H/9jyYr0rVeSiJt3SQgiDiuR/3iMI7pmMqmLjcCWzaQ12qZR2YhZrMOfvydpLZMGPZH2zm4CdColHw03Kg/NWS+IoJC94NNlyM5wkDJCVV2TdLcC+xeXEopto5f9y6SiRg5QueiJ01oIAvjCcl42mZ2wu1suviwjDCT3nbZG8URRdWJQ3FszOFyUP2TMEzNDtpsU+oe7zG9Y9tmBdNDk= clarkgar@shu-t480s-clarkgar"
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
