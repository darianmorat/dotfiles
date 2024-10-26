local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then config = wezterm.config_builder() end

-- General
config.default_domain = 'WSL:Ubuntu'
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.font = wezterm.font 'JetBrains Mono NL Slashed'
config.font_size = 14.5
config.scrollback_lines = 500
config.animation_fps = 1
config.cursor_blink_rate = 0

-- Window 
config.window_padding = {
   left = 2, 
   right = 2,
   top = 7,
   bottom = 0,
}

config.foreground_text_hsb = {
   saturation = 1.03,
   brightness = 1.2,
}

-- Colors
-- Follows GruvDark palette
config.colors = {
   foreground = '#CDC5B8',
   background = '#1E1E1E',
   cursor_bg = '#C6C5C5',
   cursor_fg = '#1E1E1E',
   cursor_border = '#C6C5C5',

   split = '#4F4F4F',

   selection_fg = '#1E1E1E',
   selection_bg = '#A9A9A9',
   scrollbar_thumb = '#4F4F4F',

   tab_bar = {
      background = '#313131', 
   },

   ansi = {
      '#4F4F4F', -- black
      '#DB6A6A', -- red
      '#76B568', -- green
      '#D19F66', -- yellow
      '#5B98C9', -- blue
      '#CD60B9', -- purple
      '#00AA9C', -- cyan
      '#CDC5B8', -- white
   },
   brights = {
      '#4F4F4F', -- brightBlack
      '#DB6A6A', -- brightRed
      '#76B568', -- brightGreen
      '#D19F66', -- brightYellow
      '#5B98C9', -- brightBlue
      '#CD60B9', -- brightPurple
      '#00AA9C', -- brightCyan
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
   { key = 'v', mods = 'CTRL', action = act{ PasteFrom="Clipboard" } },
   { key = 'c', mods = 'CTRL', action = act{ CopyTo="Clipboard" } },

   -- Tmux bindings
   { key = '0', mods = 'LEADER', action = act.ActivateTab(0) },
   { key = '1', mods = 'LEADER', action = act.ActivateTab(1) },
   { key = '2', mods = 'LEADER', action = act.ActivateTab(2) },
   { key = '3', mods = 'LEADER', action = act.ActivateTab(3) },

   { key = 's', mods = 'LEADER', action = act.ShowTabNavigator },

   { key = 'l', mods = 'LEADER', action = act.ActivateLastTab },
   { key = 'l', mods = 'LEADER|CTRL', action = act.ActivateLastTab },

   { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
   { key = 'n', mods = 'LEADER|CTRL', action = act.ActivateTabRelative(1) },

   { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
   { key = 'p', mods = 'LEADER|CTRL', action = act.ActivateTabRelative(-1) },

   { key = 'c', mods = 'LEADER', action = act{SpawnTab="CurrentPaneDomain"} },
   { key = 'd', mods = 'LEADER', action = act{CloseCurrentTab={confirm=true}} },

   -- Nvim toogle docs 
   { key = 'Space', mods = 'LEADER|CTRL', action = act.SendKey { key = 'z', mods = 'CTRL' } },
}

-- Visual
-- config.background = {
--    {
--       source = {
--          File = 'd:/apps/wezterm/images/32.jpg',
--       },
--       opacity = 1.0,
--    },
--    {
--       source = {
--          Color = "#202020",
--       },
--       width = "400",
--       height = "1080",
--       opacity = 0.94,
--    }
-- }

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
