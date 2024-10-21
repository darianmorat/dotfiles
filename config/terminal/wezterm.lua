local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then config = wezterm.config_builder() end

-- General
config.default_domain = 'WSL:Ubuntu'
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.color_scheme = 'Dark+'
config.font = wezterm.font 'JetBrains Mono NL Slashed'
config.font_size = 14.0
config.scrollback_lines = 1000
config.animation_fps = 0
config.cursor_blink_rate = 0

-- Window 
config.window_padding = {
   left = 2, 
   right = 0,
   top = 2,
   bottom = 0,
}

config.foreground_text_hsb = {
   saturation = 1.03,
   brightness = 1.2,
}

-- Colors
-- Follows GruvDark palette
config.colors = {
   tab_bar = {
      background = '#313131', 
   },

   foreground = '#CDC5B8',
   background = '#1E1E1E',
   cursor_bg = '#c6c5c5',
   cursor_fg = '#1E1E1E',
   cursor_border = '#c6c5c5',

   selection_fg = '#1E1E1E',
   selection_bg = '#A9A9A9',
   scrollbar_thumb = '#4F4F4F',
   split = '#4F4F4F',

   ansi = {
      '#4F4F4F', -- black
      '#DB6A6A', -- red
      '#76B568', -- green
      '#D19F66', -- yellow
      '#5B98C9', -- blue
      '#CD60B9', -- purple
      '#4DB0BD', -- cyan
      '#CDC5B8', -- white
   },
   brights = {
      '#4F4F4F', -- brightBlack
      '#DB6A6A', -- brightRed
      '#76B568', -- brightGreen
      '#D19F66', -- brightYellow
      '#5B98C9', -- brightBlue
      '#CD60B9', -- brightPurple
      '#4DB0BD', -- brightCyan
      '#CDC5B8', -- brightWhite
   },

   indexed = {},
   copy_mode_active_highlight_bg = { Color = '#1E1E1E' },
   copy_mode_active_highlight_fg = { Color = '#CDC5B8' },
   copy_mode_inactive_highlight_bg = { Color = '#76B568' },
   copy_mode_inactive_highlight_fg = { Color = '#CDC5B8' },
   quick_select_label_bg = { Color = '#D19F66' },
   quick_select_label_fg = { Color = '#CDC5B8' },
   quick_select_match_bg = { Color = '#5B98C9' },
   quick_select_match_fg = { Color = '#CDC5B8' },
}

-- Bindings 
local act = wezterm.action
config.leader = { key = 'Space', mods = 'CTRL' }

config.keys = {
   -- Better copy-paste
   { key = 'v', mods = 'CTRL', action = wezterm.action{ PasteFrom="Clipboard" } },
   { key = 'c', mods = 'CTRL', action = wezterm.action{ CopyTo="Clipboard" } },

   -- Tmux bindings
   { key = '0', mods = 'LEADER', action = wezterm.action.ActivateTab(0) },
   { key = '1', mods = 'LEADER', action = wezterm.action.ActivateTab(1) },
   { key = '2', mods = 'LEADER', action = wezterm.action.ActivateTab(2) },
   { key = '3', mods = 'LEADER', action = wezterm.action.ActivateTab(3) },

   { key = 'l', mods = 'LEADER', action = wezterm.action.ActivateLastTab },
   { key = 'l', mods = 'LEADER|CTRL', action = wezterm.action.ActivateLastTab },

   { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
   { key = 'n', mods = 'LEADER|CTRL', action = wezterm.action.ActivateTabRelative(1) },

   { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
   { key = 'p', mods = 'LEADER|CTRL', action = wezterm.action.ActivateTabRelative(-1) },

   { key = 'c', mods = 'LEADER', action = wezterm.action{SpawnTab="CurrentPaneDomain"} },
   { key = 'd', mods = 'LEADER', action = wezterm.action{CloseCurrentTab={confirm=true}} },

   -- Nvim toogle docs 
   { key = 'Space', mods = 'LEADER|CTRL', action = act.SendKey { key = 'z', mods = 'CTRL' } },

   -- Show current tabs
   { key = 's', mods = 'LEADER', action = wezterm.action.ShowTabNavigator },
}

-- Status-bar
-- config.tab_bar_at_bottom = true
-- config.use_fancy_tab_bar = false
-- config.show_new_tab_button_in_tab_bar = false
-- config.tab_and_split_indices_are_zero_based = true
-- config.enable_scroll_bar = false
--
-- function tab_title(tab_info)
--    return tab_info.tab_index .. ":" .. "nvim-"
-- end
--
-- wezterm.on(
--    'format-tab-title',
--    function(tab)
--       local title = tab_title(tab)
--
--       if tab.is_active then
--          title = wezterm.truncate_right(title, 6) .. "*"
--       end
--
--       return {
--          { Background = { Color = '#313131' } },
--          { Foreground = { Color = '#CDC5B8' } },
--          { Text = ' ' .. title .. ' ' },
--       }
--    end
-- )
--
-- wezterm.on('update-right-status', function(window, pane)
--    local date = wezterm.strftime '%m-%d-%y %H:%M '
--    window:set_right_status(wezterm.format {
--       { Text =":Hello World!  ".. date },
--    })
-- end)

return config
