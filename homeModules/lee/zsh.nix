{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    # # Optional: oh-my-zsh if you want plugins/themes that way
    # oh-my-zsh = {
    #   enable = true;
    #   theme = "robbyrussell"; # can change later or disable
    #   plugins = ["git" "sudo" "history-substring-search" "z"];
    # };

    shellAliases = {
      cat = "bat -s";
      g = "git";
      ll = "ls -lah";
      lt = "ls -laht";
    };

    # The declarative replacement for .zshrc
    initContent = ''
      # Load your preferred prompt
      source ~/.config/zsh/prompt.zsh
      export TERM=xterm-256color

      # export FZF_DEFAULT_OPTS="
      #   --height 40% --layout=reverse --info=inline
      #   --color=fg:$EB_FG,header:$EB_DIM,spinner:$EB_ACC,fg+:$EB_FG,hl:$EB_ACC
      # "

      eval "$(starship init zsh)"

      # Example env vars
      export EDITOR="zed"
      export LANG="en_US.UTF-8"

      # Set a custom greeting
      echo "👋 Welcome back, Lee."
    '';
  };

  # Better shell prompt!
  programs.starship = {
    enable = true;
    settings = {
      # universal prompt layout
      format = "$username$hostname$directory$git_branch$git_status$line_break$character";

      # COLORS — matched to your WezTerm palette
      # Ebony green:   #5D6658
      # Off-white fg:  #dbe6dd
      # Muted yellow:  #9c8a6a
      # Muted blue:    #5b6a6f
      # Muted red:     #b7685a

      add_newline = true;

      # Username + Host
      username = {
        style_user = "bold #5b6a6f"; # muted blue-gray
        style_root = "bold #b7685a"; # muted red
        format = "[$user]($style)";
        show_always = true;
      };

      hostname = {
        ssh_symbol = "🌐 ";
        format = " on [$hostname](bold #9c8a6a)";
        trim_at = ".local";
        ssh_only = false;
      };

      # Directory
      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        style = "bold #5D6658"; # your signature Ebony green
        read_only = " 🔒";
        format = " [$path]($style)[$read_only]($read_only_style)";
      };

      # Git
      git_branch = {
        symbol = "🌿 ";
        style = "bold #a7b39f"; # brightened green from your palette
        format = " [$symbol$branch]($style)";
      };

      git_status = {
        style = "#d2c1a0"; # soft yellow
        format = " [$all_status$ahead_behind]($style)";
      };

      # Prompt symbol
      character = {
        success_symbol = "[❯](bold #5D6658)";
        error_symbol = "[❯](bold #b7685a)";
        vicmd_symbol = "[❮](bold #5b6a6f)";
        format = "$symbol ";
      };

      # Time (optional subtle clock)
      time = {
        disabled = false;
        format = "[$time]($style) ";
        time_format = "%H:%M";
        style = "dim #5a6059";
      };

      # Disable noisy modules
      battery.disabled = true;
      package.disabled = true;
      nodejs.disabled = true;
      rust.disabled = true;
      golang.disabled = true;
      python.disabled = true;
    };
  };

  # This will make your zsh your login shell
  # loginShell = true;

  # Ensure your custom prompt file is copied in
  home.file.".config/zsh/prompt.zsh".source = ./config/zsh/ebony-prompt.zsh;
}
