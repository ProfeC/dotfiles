# modules/home/lee/default.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./desktops/niri
    ./editors/nano.nix
    # ./editors/neovim.nix
    ./editors/obsidian.nix
    ./editors/zed.nix
    ./gaming/minecraft.nix
    ./vivaldi.nix
    ./vscodium.nix
    ./wezterm.nix
    ./zsh.nix
  ];

  home.homeDirectory = "/home/lee";
  home.stateVersion = "25.05";
  home.username = "lee";

  ####################
  # Core Packages
  ####################
  home.packages = with pkgs; [
    cifs-utils
    kdePackages.kate
    libreoffice-fresh
    obsidian
    steam
    # steam.cmd
  ];

  ####################
  # Fonts
  ####################
  fonts = {
    fontconfig.enable = true;
  };

  ####################
  # Git Config
  ####################
  programs.git = {
    enable = true;
    settings = {
      user.name = "G. L. Clark, II";
      user.email = "gclark2@gmail.com";
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
    # compression = true;
  };

  ####################
  # Programs Configuration
  ####################
  programs.home-manager.enable = true;
  programs.fish.enable = true;
  programs.fzf.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -lah";
      lt = "ls -laht";
    };
  };

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
