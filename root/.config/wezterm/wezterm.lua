-- --------------------------------------------------------------------------------------
-- GENERAL
-- --------------------------------------------------------------------------------------
local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

if wezterm.config_builder then
   config = wezterm.config_builder()
end

config.window_background_opacity = 1
config.skip_close_confirmation_for_processes_named = {
   "bash",
   "sh",
   "zsh",
   "fish",
   "tmux",
   "nu",
   "cmd.exe",
   "pwsh.exe",
   "powershell.exe",
}

config.font = wezterm.font({
   family = "JetBrainsMono Nerd Font Mono",
   weight = "Medium",
   harfbuzz_features = { "zero", "calt=0", "clig=0", "liga=0" },
})

config.font_size = 12.0
config.cell_width = 0.90
config.line_height = 1.0

config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"

config.scrollback_lines = 3000
config.animation_fps = 1
config.cursor_blink_rate = 0

config.enable_tab_bar = false
config.enable_scroll_bar = false
config.switch_to_last_active_tab_when_closing_tab = true

config.window_padding = {
   left = 6,
   right = 0,
   top = 3,
   bottom = 2,
}

-- --------------------------------------------------------------------------------------
-- KEYMAPS
-- --------------------------------------------------------------------------------------
config.leader = { key = "F12", mods = "CTRL" }

config.keys = {
   { key = "j", mods = "CTRL", action = act.ActivateLastTab },

   { key = "c", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },
   { key = "d", mods = "LEADER", action = act({ CloseCurrentTab = { confirm = true } }) },

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
   local theme_file = os.getenv("HOME") .. "/.config/current_theme"
   local f = io.open(theme_file, "r")
   if not f then
      return "dark"
   end
   local theme = f:read("*l")
   f:close()
   return theme or "dark"
end

local current_theme = read_current_theme()
if current_theme == "light" then
   config.colors = require("colors.light")
else
   config.colors = require("colors.dark")
end

-- --------------------------------------------------------------------------------------
-- ENDING
-- --------------------------------------------------------------------------------------
return config
