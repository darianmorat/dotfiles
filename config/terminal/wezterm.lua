-- --------------------------------------------------------------------------------------
-- MAIN
-- --------------------------------------------------------------------------------------
local wezterm = require("wezterm")
local themes = require("gruvdark")

local act = wezterm.action
local config = {}

if wezterm.config_builder then
   config = wezterm.config_builder()
end

config.default_domain = "WSL:Ubuntu"
config.window_decorations = "RESIZE"

config.colors = themes.gruvdark
config.foreground_text_hsb = {
   brightness = 1.20, -- Just for dark themes
}

config.font = wezterm.font({
   family = "JetBrains Mono NL Slashed",
   weight = "Regular",
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
config.tab_and_split_indices_are_zero_based = false

config.window_padding = {
   left = 5,
   right = 5,
   top = 7,
   bottom = 0,
}

-- --------------------------------------------------------------------------------------
-- KEYS
-- --------------------------------------------------------------------------------------
config.leader = { key = "F12", mods = "CTRL" }

config.keys = {
   { key = "c", mods = "CTRL", action = act({ CopyTo = "Clipboard" }) },
   { key = "v", mods = "CTRL", action = act({ PasteFrom = "Clipboard" }) },
   { key = "j", mods = "CTRL", action = act.ActivateLastTab },

   { key = "c", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },
   { key = "d", mods = "LEADER", action = act({ CloseCurrentTab = { confirm = true } }) },
   { key = "x", mods = "LEADER", action = act.ActivateCopyMode },

   { key = "e", mods = "LEADER", action = wezterm.action.SendString("\x15vifm\n") },
   { key = "v", mods = "LEADER", action = wezterm.action.SendString("\x15nvim\n") },

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
-- END
-- --------------------------------------------------------------------------------------
return config
