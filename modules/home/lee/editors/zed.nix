# modules/home/lee/editors/zed.nix
{
  config,
  lib,
  pkgs,
  ...
}: let
  user_config =
    # Zed settings
    #
    # For information on how to configure Zed, see the Zed
    # documentation: https://zed.dev/docs/configuring-zed
    #
    # To see all of Zed's default settings without changing your
    # custom settings, run `zed: open default settings` from the
    # command palette (cmd-shift-p / ctrl-shift-p)
    {
      "buffer_font_size" = 15;
      "buffer_font_features" = {
        "calt" = true;
      };
      "experimental.theme_overrides" = {
        "syntax" = {
          "comment" = {
            "font_style" = "italic";
            "color" = "#828e80";
            "font_weight" = 200;
          };
          "comment.doc" = {
            "font_style" = "italic";
          };
        };
      };
      "hour_format" = "hour24";
      "indent_guides" = {
        "active_line_width" = 3;
        # "background_coloring" = "indent_aware";
        "coloring" = "indent_aware";
      };
      "minimap" = {
        "display_in" = "active_editor";
        "show" = "auto";
        "thumb" = "hover";
        "current_line_highlight" = "line";
      };
      "scroll_beyond_last_line" = "off";
      "show_whitespaces" = "selection";
      "show_wrap_guides" = true;
      # "show_whitespaces" = "boundary";
      "soft_wrap" = "editor_width";
      "theme" = {
        "mode" = "system";
        "light" = "Ayu Mirage";
        "dark" = "Ayu Dark";
      };
      "tabs" = {
        "git_status" = true;
        "file_icons" = true;
      };
      "title_bar" = {
        # "show_branch_icon" = true;
        # "show_menus" = true;
        "show_sign_in" = false;
      };
      "ui_font_size" = 16;
    };
in {
  # home.packages = with pkgs; [
  #   zed-editor
  # ];

  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;
    userSettings = user_config;
  };

  # Optional: convenience alias
  programs.bash.shellAliases.zed = "zed";
  programs.zsh.shellAliases.zed = "zed";
}
