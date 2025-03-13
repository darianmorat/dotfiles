-- --------------------------------------------------------------------------------------
-- MAIN
-- --------------------------------------------------------------------------------------
local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

if wezterm.config_builder then config = wezterm.config_builder() end

config.default_domain = "WSL:Ubuntu"
config.window_decorations = "RESIZE"
config.font = wezterm.font("JetBrains Mono NL Slashed")

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
-- BINDINGS 
-- --------------------------------------------------------------------------------------
config.leader = { key = "Space", mods = "ALT" }

config.keys = {
   { key = "v", mods = "CTRL", action = act{ PasteFrom = "Clipboard" } },
   { key = "c", mods = "CTRL", action = act{ CopyTo = "Clipboard" } },
   { key = ",", mods = "LEADER", action = act.ActivateCopyMode },

   -- Tab navigation
   { key = "l", mods = "LEADER", action = act.ActivateLastTab },
   { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
   { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },

   { key = "c", mods = "LEADER", action = act{ SpawnTab = "CurrentPaneDomain" } },
   { key = "d", mods = "LEADER", action = act{ CloseCurrentTab = { confirm = true } } },

   { key = "1", mods = "LEADER", action = act.ActivateTab(0) },
   { key = "2", mods = "LEADER", action = act.ActivateTab(1) },
   { key = "3", mods = "LEADER", action = act.ActivateTab(2) },
   { key = "4", mods = "LEADER", action = act.ActivateTab(3) },

   { key = "f", mods = "LEADER", action = act.ShowLauncherArgs { flags = "FUZZY|TABS" } },
   { key = "r", mods = "LEADER", action = act.PromptInputLine {
      description = "Enter new name for tab:",
      action = wezterm.action_callback(
         function(window, pane, line)
            if line then
               window:active_tab():set_title(line)
            end
         end
      )}
   },

   -- Workspace navigation
   { key = "i", mods = "LEADER", action = act.SwitchToWorkspace { name = "default" } },
   { key = "o", mods = "LEADER", action = act.SwitchToWorkspace { name = "secondary" } },

   { key = "s", mods = "LEADER", action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
   { key = "w", mods = "LEADER", action = act.PromptInputLine {
      description = "Enter new name for session:",
      action = wezterm.action_callback(
         function(window, pane, line)
            if line then
               wezterm.mux.rename_workspace(
                  wezterm.mux.get_active_workspace(),
                  line
               )
            end
         end
      )}
   },

   -- Open in shell
   { key = "j", mods = "LEADER", action = wezterm.action.SendString "\x15vifm\n" },
   { key = "k", mods = "LEADER", action = wezterm.action.SendString "\x15nvim\n" },

   -- Toogle theme
   { key = "Tab", mods = "LEADER", action = wezterm.action.EmitEvent("toggle-theme") },

   -- Disable defaults
   { key = "Enter", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },
   { key = "Tab", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
}

-- --------------------------------------------------------------------------------------
-- WEZTERM THEMES
-- --------------------------------------------------------------------------------------
local theme_file = "//wsl$/Ubuntu/home/darianmorat/.theme"

local themes = {
   dark = {
      foreground = "#CDC5B8",
      background = "#1E1E1E",
      cursor_fg = "#1E1E1E",
      cursor_bg = "#C6C5C5",
      cursor_border = "#C6C5C5",
      selection_fg = "#CDC5B8",
      selection_bg = "#303030",
      split = "#4F4F4F",
      scrollbar_thumb = "#4F4F4F",
      copy_mode_active_highlight_bg = { Color = "#1E1E1E" },
      copy_mode_active_highlight_fg = { Color = "#CDC5B8" },
      copy_mode_inactive_highlight_bg = { Color = "#76B568" },
      copy_mode_inactive_highlight_fg = { Color = "#CDC5B8" },
      quick_select_label_bg = { Color = "#D19F66" },
      quick_select_label_fg = { Color = "#CDC5B8" },
      quick_select_match_bg = { Color = "#5B98C9" },
      quick_select_match_fg = { Color = "#CDC5B8" },

      ansi = {
         "#4F4F4F", -- black
         "#DB6A6A", -- red
         "#76B568", -- green
         "#D19F66", -- yellow
         "#5B98C9", -- blue
         "#CD60B9", -- purple
         "#00AA9C", -- cyan
         "#CDC5B8", -- white
      },
      brights = {
         "#4F4F4F", -- brightBlack
         "#DB6A6A", -- brightRed
         "#76B568", -- brightGreen
         "#D19F66", -- brightYellow
         "#5B98C9", -- brightBlue
         "#CD60B9", -- brightPurple
         "#00AA9C", -- brightCyan
         "#CDC5B8", -- brightWhite
      }
   },

   light = {
      foreground = "#111111",
      background = "#f9f6e4",
      cursor_fg = "#eae7e1",
      cursor_bg = "#404040",
      cursor_border = "#404040",
      selection_fg = "#111111",
      selection_bg = "#b0b0a6",
      split = "#4F4F4F",
      scrollbar_thumb = "#4F4F4F",
      copy_mode_active_highlight_bg = { Color = "#f9f6e4" },
      copy_mode_active_highlight_fg = { Color = "#111111" },
      copy_mode_inactive_highlight_bg = { Color = "#006c00" },
      copy_mode_inactive_highlight_fg = { Color = "#111111" },
      quick_select_label_bg = { Color = "#ae5f05" },
      quick_select_label_fg = { Color = "#111111" },
      quick_select_match_bg = { Color = "#1e5a8b" },
      quick_select_match_fg = { Color = "#111111" },

      ansi = {
         "#1B1B1B", -- black
         "#9f0202", -- red
         "#006c00", -- green
         "#ae5f05", -- yellow
         "#1e5a8b", -- blue
         "#910e79", -- purple
         "#008b7f", -- cyan
         "#111111", -- white
      },
      brights = {
         "#111111", -- brightBlack
         "#9f0202", -- brightRed
         "#006c00", -- brightGreen
         "#ae5f05", -- brightYellow
         "#1e5a8b", -- brightBlue
         "#910e79", -- brightPurple
         "#008b7f", -- brightCyan
         "#111111", -- brightWhite
      }
   }
}

local function read_theme()
   local file = io.open(theme_file, "r")
   local theme = file and file:read("*l"):match("%S+") or "dark"
   if file then file:close() end
   return themes[theme] and theme or "dark"
end

local function save_theme(theme)
   local file = io.open(theme_file, "w")
   if file then file:write(theme) file:close() end
end

local current_theme = read_theme()
config.colors = themes[current_theme]

wezterm.on("toggle-theme", function(window)
   current_theme = (current_theme == "dark") and "light" or "dark"
   window:set_config_overrides({ 
      colors = themes[current_theme],
      foreground_text_hsb = (current_theme == "dark") and {
         saturation = 1.03,
         brightness = 1.2
      } or nil
   })
   save_theme(current_theme)
end)

-- --------------------------------------------------------------------------------------
-- ENDING
-- --------------------------------------------------------------------------------------
return config
