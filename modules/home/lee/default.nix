# modules/home/lee/default.nix
{ config, pkgs, lib, ... }:

{
  imports = [
    ./nano.nix
    ./neovim.nix
    # ../../editors/obsidian.nix
    ./vivaldi.nix
    ./vscodium.nix
  ];

  home.username = "lee";
  home.homeDirectory = "/home/lee";
  home.stateVersion = "25.05";

  ####################
  # Core Packages
  ####################
  home.packages = with pkgs; [
    kdePackages.kate
    obsidian
  ];

  ####################
  # Git Config
  ####################
  programs.git = {
    enable = true;
    userName = "G. L. Clark, II";
    userEmail = "gclark2@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = [
        "/etc/nixos"
        "~/etc/nixos"
        "~/Projects"
      ];
    };
  };

  ####################
  # SSH Config
  ####################
  programs.ssh = {
    enable = true;
    compression = true;
  };

  ####################
  # Programs Configuration
  ####################
  programs.bash.enable = true;
  programs.neovim.enable = true;

  ####################
  # Desktop Entries (Optional)
  ####################
  # home.file.".local/share/applications/vivaldi-tuned.desktop".text =
  #   vivaldi.environment.desktopEntries.vivaldi-tuned;

  # home.file.".local/share/applications/vivaldi-default.desktop".text =
  #   vivaldi.environment.desktopEntries.vivaldi-default;

  ####################
  # Dotfiles
  ####################
  # home.file.".zshrc".source = ./dotfiles/zshrc;
  # home.file.".gitconfig".source = ./dotfiles/gitconfig;

  ####################
  # Optional: editor configs / neovim bootstrap
  ####################
  # home.file.".config/nvim/init.lua".text = neovimCfg.config.environment.etc."xdg/config/nvim/init.lua".text;

}
