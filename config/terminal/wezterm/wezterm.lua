-- --------------------------------------------------------------------------------------
-- GENERAL
-- --------------------------------------------------------------------------------------
local wezterm = require("wezterm")
local themes = require("themes")

local act = wezterm.action
local config = {}

if wezterm.config_builder then
   config = wezterm.config_builder()
end

config.default_domain = "WSL:Ubuntu"
config.window_decorations = "RESIZE"
config.window_background_opacity = 1

config.font = wezterm.font({
   family = "JetBrains Mono NL Slashed",
   weight = "Medium",
   harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})

config.font_size = 12.5
config.cell_width = 0.90
config.line_height = 1.0

config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"

config.scrollback_lines = 500
config.animation_fps = 1
config.cursor_blink_rate = 0

config.enable_tab_bar = false
config.enable_scroll_bar = false
config.switch_to_last_active_tab_when_closing_tab = true

config.window_padding = {
   left = 5,
   right = 5,
   top = 5,
   bottom = 0,
}

-- --------------------------------------------------------------------------------------
-- KEYMAPS
-- --------------------------------------------------------------------------------------
config.leader = { key = "F12", mods = "CTRL" }

config.keys = {
   { key = "c", mods = "CTRL", action = act({ CopyTo = "Clipboard" }) },
   { key = "v", mods = "CTRL", action = act({ PasteFrom = "Clipboard" }) },

   { key = "j", mods = "CTRL", action = act.ActivateLastTab },
   { key = "x", mods = "LEADER", action = act.ActivateCopyMode },

   { key = "c", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },
   { key = "d", mods = "LEADER", action = act({ CloseCurrentTab = { confirm = true } }) },

   { key = "v", mods = "LEADER", action = wezterm.action.SendString("\x1bZ") },

   {
      key = "f",
      mods = "LEADER",
      action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }),
   },
   {
      key = "r",
      mods = "LEADER",
      action = act.PromptInputLine({
         description = "Enter new name for tab:",
         action = wezterm.action_callback(function(window, pane, line)
            if line then
               window:active_tab():set_title(line)
            end
         end),
      }),
   },

   {
      key = "s",
      mods = "LEADER",
      action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
   },
   {
      key = "w",
      mods = "LEADER",
      action = act.PromptInputLine({
         description = "Enter new name for session:",
         action = wezterm.action_callback(function(window, pane, line)
            if line then
               wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
            end
         end),
      }),
   },
}

-- --------------------------------------------------------------------------------------
-- COLORSCHEME
-- --------------------------------------------------------------------------------------
local function read_current_theme()
   local theme_file = "//wsl$/Ubuntu/home/darianmorat/.config/current_theme"
   local f = io.open(theme_file, "r")

   if not f then
      return "gruvdark"
   end

   local theme = f:read("*l")
   f:close()

   local theme_mapping = {
      dark = "gruvdark",
      light = "gruvdark_light",
   }

   return theme_mapping[theme] or "gruvdark"
end

local current_theme = read_current_theme()
config.colors = themes[current_theme]

-- --------------------------------------------------------------------------------------
-- ENDING
-- --------------------------------------------------------------------------------------
return config
