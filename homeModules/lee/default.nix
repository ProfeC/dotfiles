# homeModules/lee/default.nix
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./browsers
    # ./desktops/niri
    # ./desktops/noctalia
    ./editors/nano.nix
    # ./editors/neovim.nix
    ./editors/obsidian.nix
    ./editors/zed.nix
    ./gaming/default.nix
    ./flake-update-notify.nix
    # ./wezterm.nix
    ./zsh.nix
    ../common/gui-apps.nix
  ];

  home.homeDirectory = "/home/lee";
  home.stateVersion = "25.05";
  home.username = "lee";

  ####################
  # Core Packages
  ####################
  home.packages = with pkgs; [
    alacritty
    cifs-utils
    dbus
    libnotify
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
      pull.rebase = true;
      init.defaultBranch = "main";
      safe.directory = [
        "/etc/nixos"
        "~/etc/nixos"
        "~/Projects"
      ];
      alias = {
        st = "status";
        lg = "log --online --graph --decorate";
      };
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
  # programs.fish.enable = true;
  # programs.fzf.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      cat = "bat -s";
      g = "git";
      ll = "ls -lah";
      lt = "ls -laht";
    };
  };

  ####################
  # Desktop Entries (Optional)
  ####################


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
