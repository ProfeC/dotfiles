# modules/home/lee/default.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./nano.nix
    ./neovim.nix
    ./obsidian.nix
    ./vivaldi.nix
    ./vscodium.nix
    ./wezterm.nix
  ];

  home.homeDirectory = "/home/lee";
  home.stateVersion = "25.05";
  home.username = "lee";

  ####################
  # Core Packages
  ####################
  home.packages = with pkgs; [
    kdePackages.kate
    obsidian
    steam
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
  programs.home-manager.enable = true;
  programs.fish.enable = true;
  programs.fzf.enable = true;
  programs.neovim.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -lah";
      lt = "ls -laht";
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
    };

    shellAliases = {
      ll = "ls -lah";
      lt = "ls -laht";
    };
  };

  # Better shell prompt!
  programs.starship = {
    enable = true;
    settings = {
      username = {
        style_user = "blue bold";
        style_root = "red bold";
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };
      hostname = {
        ssh_only = false;
        ssh_symbol = "🌐 ";
        format = "on [$hostname](bold red) ";
        trim_at = ".local";
        disabled = false;
      };
    };
  };

  # home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

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
