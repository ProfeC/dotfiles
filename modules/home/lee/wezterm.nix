# modules/home/lee/wezterm.nix
{
  config,
  lib,
  pkgs,
  ...
}:

let
  wezterm_extra = builtins.readFile ./config/wezterm/wezterm-extra.lua;
in {
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    # Option A: inline config (small)
    extraConfig = ''
      -- inline Lua; small example
      -- We keep it short here; you can drop the full wezterm.lua content into a file and reference it.
      local wezterm = require("wezterm")
      wezterm.on("gui-startup", function(cmd)
        -- nothing fancy here; the full desktop config is in ./config/wezterm.
      end)
    '';
  };
}
