-- wezterm.lua — Ebony Night (Muted) for NixOS/zsh setup
local wezterm = require("wezterm")

-- helper: convert hex to wezterm color table (if needed)
local function hex(s) return s end

-- Palette (Ebony Night - Muted)
local palette = {
  background = "#0f1311",   -- charcoal-but-not-pure-black
  foreground = "#dbe6dd",   -- warm off-white
  cursor_fg  = "#0f1311",
  cursor_bg  = "#dbe6dd",
  selection_bg = "#37443c",
  black = "#0b0d0b",
  red   = "#b7685a",
  green = "#5D6658", -- your ebony anchor
  yellow = "#9c8a6a",
  blue  = "#5b6a6f",
  magenta = "#7a6f7a",
  cyan  = "#6b7a75",
  white = "#c9d3cd",
  bright_black = "#5a6059",
  bright_red   = "#e09a90",
  bright_green = "#a7b39f",
  bright_yellow= "#d2c1a0",
  bright_blue  = "#8aa0a6",
  bright_magenta= "#b7aeb7",
  bright_cyan  = "#9db4ad",
  bright_white = "#ffffff",
}

local colors = {
  foreground = palette.foreground,
  background = palette.background,
  cursor_bg = palette.cursor_bg,
  cursor_fg = palette.cursor_fg,
  cursor_border = palette.cursor_bg,
  selection_bg = palette.selection_bg,

  ansi = {
    palette.black, palette.red, palette.green, palette.yellow,
    palette.blue, palette.magenta, palette.cyan, palette.white
  },
  brights = {
    palette.bright_black, palette.bright_red, palette.bright_green, palette.bright_yellow,
    palette.bright_blue, palette.bright_magenta, palette.bright_cyan, palette.bright_white
  },

  tab_bar = {
    background = palette.background,
    active_tab = {
      bg_color = "#142018",
      fg_color = palette.foreground,
      intensity = "Bold"
    },
    inactive_tab = {
      bg_color = palette.background,
      fg_color = palette.bright_black
    },
    new_tab = {
      bg_color = palette.background,
      fg_color = palette.green
    }
  }
}

-- 🌅 Event Hooks ------------------------------------------------------------

-- Maximize window at startup
wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- Show hostname + time in the right status bar
wezterm.on("update-status", function(window, _)
  local date = wezterm.strftime("%Y-%m-%d %H:%M")
  local hostname = wezterm.hostname()
  local right_text = string.format(" %s  %s ", hostname, date)

  window:set_right_status(wezterm.format({
    { Foreground = { Color = palette.green } },
    { Text = right_text },
  }))
end)

-- 🎨 Configuration ----------------------------------------------------------

return {
  font_size = 11.0,
  line_height = 1.13,
  color_scheme = "EbonyNightMuted",

  colors = colors,

  window_background_opacity = 0.85,
  enable_scroll_bar = true,
  window_decorations = "RESIZE|TITLE",
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = true,
  kde_window_background_blur = true,
  enable_kitty_keyboard = true,
  max_fps = 120,
  scrollback_lines = 10000,

  -- Launch user’s shell
  default_prog = { os.getenv("SHELL"), "-l" },

  keys = {
    { key = "d", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "e", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Left" },
    { key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Down" },
    { key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Right" },
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo "ClipboardAndPrimarySelection" },
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom "Clipboard" },
    { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab "CurrentPaneDomain" },
    { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab { confirm = true } },
    { key = "=", mods = "CTRL|SHIFT", action = wezterm.action.IncreaseFontSize },
    { key = "-", mods = "CTRL|SHIFT", action = wezterm.action.DecreaseFontSize },
  },

  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.7,
  },

  color_schemes = {
    EbonyNightMuted = colors,
  },

  window_padding = {
    left = 13,
    right = 13,
    top = 13,
    bottom = 13,
  },
}
