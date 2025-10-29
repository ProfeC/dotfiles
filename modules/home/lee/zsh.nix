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

    # shellAliases = {
    #   ll = "ls -lah";
    # };

    # The declarative replacement for .zshrc
    initContent = ''
      # Load your preferred prompt
      source ~/.config/zsh/prompt.zsh
      export TERM=xterm-256color

      export FZF_DEFAULT_OPTS="
        --height 40% --layout=reverse --info=inline
        --color=fg:$EB_FG,header:$EB_DIM,spinner:$EB_ACC,fg+:$EB_FG,hl:$EB_ACC
      "

      # Aliases
      alias cat="bat -s"
      alias ll="ls -lah"
      alias lt="ls -laht"
      alias g="git"

      # Example env vars
      export EDITOR="nvim"
      export LANG="en_US.UTF-8"

      # Set a custom greeting
      echo "👋 Welcome back, Lee."
    '';
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

  # This will make your zsh your login shell
  # loginShell = true;

  # Ensure your custom prompt file is copied in
  home.file.".config/zsh/prompt.zsh".source = ./config/zsh/ebony-prompt.zsh;
}
