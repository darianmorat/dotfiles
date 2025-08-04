-- --------------------------------------------------------------------------------------
-- SETTINGS
-- --------------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.pumheight = 10

vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.cmdheight = 0
vim.opt.laststatus = 0

vim.opt.updatetime = 100
vim.opt.mouse = "a"
vim.opt.guicursor = ""
vim.opt.number = true
vim.opt.cursorline = true

vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.tabstop = 3
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.spell = false
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"

vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 6
vim.opt.colorcolumn = "90"
vim.opt.signcolumn = "yes"
vim.opt.undofile = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.fileencoding = "utf-8"
vim.opt.fillchars = { eob = " " }
vim.g.markdown_recommended_style = 0

vim.schedule(function()
   vim.opt.clipboard = "unnamedplus"
end)

-- --------------------------------------------------------------------------------------
-- REMAPS
-- --------------------------------------------------------------------------------------
local function smart_quit() -- Fix: quit in diff
   if vim.wo.diff then
      vim.cmd("wincmd p | q")
   else
      vim.cmd(":q")
   end
end

vim.keymap.set("n", "<leader>q", smart_quit)
vim.keymap.set("n", "<leader>w", ":silent w<cr>", { silent = true })
vim.keymap.set("n", "<leader>d", "<cmd>bd<cr>")
vim.keymap.set("n", "<leader><leader>d", "<cmd>bd!<cr>")
vim.keymap.set("n", "<leader><leader>b", "<cmd>BufOnly<cr>")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "K", "m`i<cr><Esc>``")
vim.keymap.set("n", "J", "m`J``")

vim.keymap.set("n", "<C-h>", "<C-6>")
vim.keymap.set("n", "<leader>r", "<c-g>")

vim.keymap.set({ "n", "v" }, "<leader>y", '"ay')
vim.keymap.set({ "n", "v" }, "<leader>p", '"ap')
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d')

vim.keymap.set("n", "<leader>ti", "<cmd>IBLToggle<cr>")
vim.keymap.set("n", "<leader>ts", "<cmd>set spell!<cr>")
vim.keymap.set("n", "<leader>tn", "<cmd>set relativenumber!<cr>")
vim.keymap.set("n", "<leader>tw", "<cmd>set wrap!<cr>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { silent = true })

-- --------------------------------------------------------------------------------------
-- PLUGIN LIST
-- --------------------------------------------------------------------------------------
local plugins = {
   {
      -- In development...
      -- This would be the only theme left
      dir = "~/dev/test-code/gruvdark.nvim",
   },

   {
      -- For testing...
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
   },
   {
      -- For testing...
      "navarasu/onedark.nvim",
      lazy = false,
      priority = 1000,
      config = function()
         local themes = {
            gruvdark = {
               code_style = { comments = "none" },
               colors = {
                  fg = "#D6CFC4",
                  fg_bright = "#E6E3DE",

                  blue = "#579DD4",
                  red = "#E16464",
                  -- red_dark = "#B55353", -- use this for darker reds
                  green = "#72BA62",
                  purple = "#D159B6", -- this is pink for my theme
                  purple_2 = "#9266DA",

                  aqua = "#00A596",
                  cyan = "#00A596", -- just aqua for my theme
                  orange = "#D19F66",
                  yellow = "#D19F66", -- just orange for my theme

                  grey = "#575757",
                  lightGrey = "#9D9A94",

                  bg = "#1E1E1E",
                  bg1 = "#303030",
                  bg2 = "#313131",

                  menu = "#454545",
               },
               highlights = {
                  Normal = { fg = "$fg", bg = "$bg" },
                  NormalFloat = { fg = "$fg", bg = "$bg" },
                  FloatBorder = { fg = "$fg", bg = "$bg" },
                  MsgArea = { fg = "$fg", bg = "$bg" },
                  StatusLine = { fg = "$fg", bg = "#252525" },
                  FloatermBorder = { fg = "NONE", bg = "$bg" },
                  FloatTitle = { fg = "$red" },
                  SignColumn = { bg = "$bg" },
                  YankHighlight = { fg = "$fg_bright", bg = "$bg1" },

                  Search = { fg = "$bg", bg = "#B55353" },
                  FlashCurrent = { fg = "$bg", bg = "#B55353" },
                  IncSearch = { fg = "$fg_bright", bg = "#B55353" },
                  FlashLabel = { fg = "$fg_bright", bg = "#2A404F" },

                  MatchParen = { fg = "$fg_bright", bg = "$menu" },
                  Folded = { fg = "$fg", bg = "#282828" },
                  CursorLine = { bg = "NONE" },
                  CursorLineNr = { fg = "$lightGrey" },
                  LineNr = { fg = "$grey" },
                  ColorColumn = { bg = "#222222" },
                  EndOfBuffer = { fg = "#323232", bg = "NONE" }, -- not importnat for my theme
                  IblIndent = { fg = "#323232" },
                  WinSeparator = { fg = "#2F2F2F" },
                  Visual = { bg = "$bg1" },

                  BlinkCmpLabelMatch = { fg = "$green" },
                  PmenuSel = { fg = "#E1DCD6", bg = "$menu" },
                  -- CmpItemAbbrMatch = { fg = "$green" },
                  -- CmpItemAbbrMatchFuzzy = { fg = "$green" },
                  -- CmpItemKindText = { fg = "$lightGrey" },
                  -- CmpItemMenu = { fg = "$lightGrey" },

                  TSParameter = { fg = "$fg" },
                  TSParameterReference = { fg = "$fg" },

                  -- General
                  ["@none"] = { fg = "NONE" },
                  ["@spell"] = { fg = "NONE" },
                  ["@variable.parameter"] = { fg = "$fg" },
                  ["@lsp.type.parameter"] = { fg = "$fg" },
                  ["@keyword.function"] = { fg = "$blue" },
                  ["@keyword"] = { fg = "$blue" },
                  ["@keyword.conditional.ternary"] = { fg = "$blue" },
                  ["@keyword.return"] = { fg = "$purple" },
                  ["@keyword.conditional"] = { fg = "$purple" },
                  ["@keyword.repeat"] = { fg = "$purple" },
                  ["@keyword.import"] = { fg = "$purple" },
                  ["@keyword.export"] = { fg = "$purple" },
                  ["@function"] = { fg = "$red" },
                  ["@function.builtin"] = { fg = "$red" },
                  ["@function.method"] = { fg = "$red" },
                  ["@variable.builtin"] = { fg = "$orange" },
                  ["@string"] = { fg = "$green" },
                  ["@lsp.type.namespace"] = { fg = "$aqua" },
                  ["@constructor"] = { fg = "$aqua" },
                  ["@variable.member"] = { fg = "$fg" },

                  -- Symbols
                  ["@comment"] = { fg = "$grey" },
                  ["@operator"] = { fg = "$blue" },
                  ["@punctuation"] = { fg = "$fg" },
                  ["@punctuation.bracket"] = { fg = "$fg" },
                  ["@punctuation.delimiter"] = { fg = "$lightGrey" },

                  -- Html
                  ["@tag"] = { fg = "$red" },
                  ["@tag.delimiter"] = { fg = "$red" },
                  ["@tag.attribute"] = { fg = "$purple_2" },

                  -- Css
                  ["@property.css"] = { fg = "$blue" },
                  ["@string.css"] = { fg = "$orange" },
                  ["@string.plain.css"] = { fg = "$fg" },
                  ["@tag.css"] = { fg = "$red" },
                  ["@constant.css"] = { fg = "$red" },
                  ["@property.id.css"] = { fg = "$red" },
                  ["@property.class.css"] = { fg = "$red" },
                  ["@tag.attribute.css"] = { fg = "$fg" },
                  ["@type.css"] = { fg = "$red" },
                  ["@type.tag.css"] = { fg = "$red" },
                  ["@operator.css"] = { fg = "$fg" },
                  ["@attribute.css"] = { fg = "$red" },
                  ["@keyword.modifier.css"] = { fg = "$purple" },

                  -- Lua
                  ["@constructor.lua"] = { fg = "$fg" },
                  ["@keyword.operator.lua"] = { fg = "$blue" },
                  ["@module.builtin.lua"] = { fg = "$aqua" },
                  ["@property.lua"] = { fg = "$fg" },

                  -- Json
                  ["@property.json"] = { fg = "$red" },

                  -- Markdown
                  ["@label.markdown"] = { fg = "$grey" },
                  ["@markup.raw.block.markdown"] = { fg = "$green" },
                  ["@markup.heading.1.markdown"] = { fg = "$red" },
                  ["@markup.heading.2.markdown"] = { fg = "$red" },
                  ["@markup.heading.3.markdown"] = { fg = "$red" },
                  ["@markup.heading.4.markdown"] = { fg = "$red" },
                  ["@markup.heading.5.markdown"] = { fg = "$red" },
                  ["@markup.heading.6.markdown"] = { fg = "$red" },

                  ["@markup.heading.html"] = { fg = "$orange" },
                  ["@markup.heading.1.html"] = { fg = "$orange" },
                  ["@markup.heading.2.html"] = { fg = "$orange" },
                  ["@markup.heading.3.html"] = { fg = "$orange" },
                  ["@markup.heading.4.html"] = { fg = "$orange" },
                  ["@markup.heading.5.html"] = { fg = "$orange" },
                  ["@markup.heading.6.html"] = { fg = "$orange" },

                  -- Typescript Javascript
                  ["@lsp.typemod.function.defaultLibrary"] = { fg = "$red" },

                  -- Typescript
                  ["@tag.tsx"] = { fg = "$aqua" },
                  ["@type.tsx"] = { fg = "$fg" },
                  ["@type.typescript"] = { fg = "$fg" },
                  ["@constant.tsx"] = { fg = "$fg" },
                  ["@constant.typescript"] = { fg = "$fg" },
                  ["@keyword.directive.typescript"] = { fg = "$green" },

                  ["@lsp.typemod.property.declaration.typescript"] = { fg = "$fg" },
                  ["@lsp.typemod.property.defaultLibrary.typescript"] = { fg = "$orange" },
                  ["@lsp.typemod.variable.defaultLibrary.typescript"] = { fg = "$orange" },
                  ["@lsp.typemod.variable.defaultLibrary.typescriptreact"] = {
                     fg = "$orange",
                  },

                  -- Javascript
                  ["@tag.javascript"] = { fg = "$aqua" },
                  ["@type.javascript"] = { fg = "$fg" },
                  ["@constant.javascript"] = { fg = "$fg" },
                  ["@lsp.type.class.javascript"] = { fg = "$aqua" },

                  ["@lsp.typemod.property.declaration.javascript"] = { fg = "$fg" },
                  ["@lsp.typemod.property.defaultLibrary.javascript"] = { fg = "$orange" },
                  ["@lsp.typemod.variable.defaultLibrary.javascript"] = { fg = "$orange" },
                  ["@lsp.typemod.variable.defaultLibrary.javascriptreact"] = {
                     fg = "$orange",
                  },

                  ["@markup.raw.javascript"] = { fg = "$fg" },
                  ["@markup.heading.1.javascript"] = { fg = "$orange", fmt = "none" },
               },
            },

            -- LIGH THEME
            -- gruvdark_light = {
            --    code_style = { comments = "none" },
            --    colors = {
            --       fg = "#111111",
            --       blue = "#1E5A8B",
            --       red = "#9F0202",
            --       green = "#006C00",
            --       purple = "#910E79", -- this is pink for my theme
            --
            --       aqua = "#008B7F",
            --       cyan = "#008B7F", -- just aqua for my theme
            --       orange = "#AE5F05",
            --       yellow = "#AE5F05", -- just orange for my theme
            --
            --       grey = "#707070",
            --       lightGrey = "#8D8A85",
            --
            --       bg = "#F7F5EA",
            --       bg2 = "#E9E8DD",
            --       bg1 = "#B0B0A6",
            --    },
            --    highlights = {
            --       -- Interface
            --       Normal = { fg = "$fg", bg = "$bg" },
            --       NormalFloat = { fg = "$fg", bg = "$bg" },
            --       FloatBorder = { fg = "$fg", bg = "$bg" },
            --       MsgArea = { fg = "$fg", bg = "$bg" },
            --       StatusLine = { fg = "$fg", bg = "#e0ddd7" },
            --       FloatermBorder = { fg = "NONE", bg = "$bg" },
            --       FloatTitle = { fg = "$red" },
            --       SignColumn = { bg = "$bg" },
            --       YankHighlight = { fg = "$fg", bg = "#cececa" },
            --
            --       Search = { fg = "$fg", bg = "#ebd09c" },
            --       FlashCurrent = { fg = "$fg", bg = "#ebd09c" },
            --       FlashLabel = { fg = "$fg", bg = "#df7474" },
            --       IncSearch = { fg = "$fg", bg = "#df7474" },
            --
            --       MatchParen = { bg = "#b0b0a6" },
            --       Folded = { fg = "$fg", bg = "#b0b0a6" },
            --       CursorLine = { bg = "NONE" },
            --       CursorLineNr = { fg = "#404040" },
            --
            --       Cursor = { fg = "$bg", bg = "#404040", fmt = "bold" },
            --       Cursor2 = { fg = "$bg", bg = "#BF5959" },
            --
            --       LineNr = { fg = "#828282" },
            --       ColorColumn = { bg = "#f0efe4" },
            --       EndOfBuffer = { fg = "#303030", bg = "NONE" },
            --       Visual = { bg = "$bg1" },
            --
            --       CmpItemAbbrMatch = { fg = "$green" },
            --       CmpItemAbbrMatchFuzzy = { fg = "$green", fmt = "none" },
            --       CmpItemKindText = { fg = "$lightGrey" },
            --       CmpItemMenu = { fg = "$lightGrey" },
            --       Pmenu = { fg = "$fg", bg = "$bg2" },
            --       PmenuSel = { fg = "$fg", bg = "$bg1" },
            --
            --       TSParameter = { fg = "$fg" },
            --       TSParameterReference = { fg = "$fg" },
            --
            --       -- General
            --       ["@none"] = { fg = "NONE" },
            --       ["@spell"] = { fg = "NONE" },
            --       ["@variable.parameter"] = { fg = "$fg" },
            --       ["@lsp.type.parameter"] = { fg = "$fg" },
            --       ["@keyword.function"] = { fg = "$blue" },
            --       ["@keyword"] = { fg = "$blue" },
            --       ["@keyword.conditional.ternary"] = { fg = "$blue" },
            --       ["@keyword.return"] = { fg = "$purple" },
            --       ["@keyword.conditional"] = { fg = "$purple" },
            --       ["@keyword.repeat"] = { fg = "$purple" },
            --       ["@keyword.import"] = { fg = "$purple" },
            --       ["@keyword.export"] = { fg = "$purple" },
            --       ["@function"] = { fg = "$red" },
            --       ["@function.builtin"] = { fg = "$red" },
            --       ["@function.method"] = { fg = "$red" },
            --       ["@variable.builtin"] = { fg = "$orange" },
            --       ["@string"] = { fg = "$green" },
            --       ["@lsp.type.namespace"] = { fg = "$aqua" },
            --       ["@constructor"] = { fg = "$aqua" },
            --       ["@variable.member"] = { fg = "$fg" },
            --
            --       -- Symbols
            --       ["@comment"] = { fg = "#828282" },
            --       ["@operator"] = { fg = "$blue" },
            --       ["@punctuation"] = { fg = "$fg" },
            --       ["@punctuation.bracket"] = { fg = "$fg" },
            --       ["@punctuation.delimiter"] = { fg = "$lightGrey" },
            --
            --       -- Html
            --       ["@tag"] = { fg = "$red" },
            --       ["@tag.delimiter"] = { fg = "$red" },
            --       ["@tag.attribute"] = { fg = "#480AAB" },
            --       ["@markup.heading.1.html"] = { fg = "$fg", fmt = "none" },
            --       ["@markup.heading.html"] = { fg = "$fg", fmt = "none" },
            --
            --       -- Css
            --       ["@property.css"] = { fg = "$blue" },
            --       ["@string.css"] = { fg = "$orange" },
            --       ["@string.plain.css"] = { fg = "$fg" },
            --       ["@tag.css"] = { fg = "$red" },
            --       ["@constant.css"] = { fg = "$red" },
            --       ["@property.id.css"] = { fg = "$red" },
            --       ["@property.class.css"] = { fg = "$red" },
            --       ["@tag.attribute.css"] = { fg = "$fg" },
            --       ["@type.css"] = { fg = "$red" },
            --       ["@type.tag.css"] = { fg = "$red" },
            --       ["@operator.css"] = { fg = "$fg" },
            --       ["@attribute.css"] = { fg = "$red" },
            --       ["@keyword.modifier.css"] = { fg = "$purple" },
            --
            --       -- Lua
            --       ["@constructor.lua"] = { fg = "$fg" },
            --       ["@keyword.operator.lua"] = { fg = "$blue" },
            --       ["@module.builtin.lua"] = { fg = "$aqua" },
            --       ["@property.lua"] = { fg = "$fg" },
            --
            --       -- Json
            --       ["@property.json"] = { fg = "$red" },
            --
            --       -- Markdown
            --       htmlTag = { fg = "$red" },
            --       htmlTagName = { fg = "$red" },
            --       markdownCodeDelimiter = { fg = "$green" },
            --       markdownLinkText = { fg = "$blue" },
            --       markdownUrl = { fg = "$green" },
            --       markdownCode = { fg = "$green" },
            --       markdownListMarker = { fg = "$blue" },
            --       ["@label.markdown"] = { fg = "$red" },
            --       ["@markup.raw.block.markdown"] = { fg = "$red" },
            --       ["@markup.heading.1.html"] = { fg = "$orange" },
            --       ["@markup.heading.html"] = { fg = "$orange" },
            --
            --       -- Typescript Javascript
            --       ["@lsp.typemod.function.defaultLibrary"] = { fg = "$red" },
            --
            --       -- Typescript
            --       ["@tag.tsx"] = { fg = "$aqua" },
            --       ["@type.tsx"] = { fg = "$fg" },
            --       ["@type.typescript"] = { fg = "$fg" },
            --       ["@constant.tsx"] = { fg = "$fg" },
            --       ["@constant.typescript"] = { fg = "$fg" },
            --       ["@keyword.directive.typescript"] = { fg = "$green" },
            --
            --       ["@lsp.typemod.property.declaration.typescript"] = { fg = "$fg" },
            --       ["@lsp.typemod.property.defaultLibrary.typescript"] = { fg = "$orange" },
            --       ["@lsp.typemod.variable.defaultLibrary.typescript"] = { fg = "$orange" },
            --       ["@lsp.typemod.variable.defaultLibrary.typescriptreact"] = {
            --          fg = "$orange",
            --       },
            --
            --       -- Javascript
            --       ["@tag.javascript"] = { fg = "$aqua" },
            --       ["@type.javascript"] = { fg = "$fg" },
            --       ["@constant.javascript"] = { fg = "$fg" },
            --       ["@lsp.type.class.javascript"] = { fg = "$aqua" },
            --
            --       ["@lsp.typemod.property.declaration.javascript"] = { fg = "$fg" },
            --       ["@lsp.typemod.property.defaultLibrary.javascript"] = { fg = "$orange" },
            --       ["@lsp.typemod.variable.defaultLibrary.javascript"] = { fg = "$orange" },
            --       ["@lsp.typemod.variable.defaultLibrary.javascriptreact"] = {
            --          fg = "$orange",
            --       },
            --
            --       ["@markup.raw.javascript"] = { fg = "$fg" },
            --       ["@markup.heading.1.javascript"] = { fg = "$orange", fmt = "none" },
            --    },
            -- },
         }

         require("onedark").setup(themes.gruvdark)
         require("onedark").load()
      end,
   },

   {
      "stevearc/oil.nvim",
      event = "VeryLazy",
      opts = {
         keymaps = {
            ["<BS>"] = { "actions.parent", mode = "n" },
            ["<CR>"] = "actions.select",
            ["_"] = { "actions.open_cwd", mode = "n" },
            ["q"] = { "actions.close", mode = "n" },
            ["g."] = { "actions.toggle_hidden", mode = "n" },
            ["gt"] = { "actions.toggle_trash", mode = "n" },

            ["<C-s>"] = { "actions.select", opts = { vertical = true } },
            ["<C-l>"] = "actions.refresh",
            ["g?"] = { "actions.show_help", mode = "n" },
            ["gs"] = { "actions.change_sort", mode = "n" },
            ["gx"] = "actions.open_external",

            ["<C-f>"] = {
               callback = function()
                  require("fzf-lua").files({
                     cwd = vim.fn.getcwd(),
                     fd_opts = "--color=never --type d --hidden --follow --exclude .git",
                     previewer = false,
                  })
               end,
               mode = "n",
            },

            ["<C-g>"] = {
               callback = function()
                  require("fzf-lua").files({
                     cwd = require("oil").get_current_dir(),
                     fd_opts = "--color=never --type d --hidden --follow --exclude .git",
                     previewer = false,
                  })
               end,
               mode = "n",
            },

            ["<C-p>"] = {
               callback = function()
                  local oil = require("oil")
                  local util = require("oil.util")
                  local entry = oil.get_cursor_entry()
                  if not entry then
                     vim.notify("Could not find entry under cursor", vim.log.levels.ERROR)
                     return
                  end
                  local winid = util.get_preview_win()
                  if winid then
                     local cur_id = vim.w[winid].oil_entry_id
                     if entry.id == cur_id then
                        vim.api.nvim_win_close(winid, true)
                        if util.is_floating_win() then
                           local layout = require("oil.layout")
                           local win_opts = layout.get_fullscreen_win_opts()
                           vim.api.nvim_win_set_config(0, win_opts)
                        end
                        return
                     end
                  end
                  oil.open_preview({ vertical = true, split = "botright" })
               end,
            },
         },
         use_default_keymaps = false,
         delete_to_trash = true,
         view_options = {
            show_hidden = true,
            is_always_hidden = function(name, bufnr)
               return name == ".."
            end,
         },
         win_options = { signcolumn = "yes:2" },
         confirmation = { border = "single" },
         progress = { border = "single" },
         ssh = { border = "single" },
         keymaps_help = { border = "single" },
      },

      config = function(_, opts)
         require("oil").setup(opts)
         vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>")

         vim.api.nvim_create_autocmd("FileType", {
            pattern = "oil_preview",
            callback = function(params)
               vim.keymap.set("n", "<cr>", "o", {
                  buffer = params.buf,
                  remap = true,
                  nowait = true,
               })
            end,
         })
      end,
   },

   {
      "refractalize/oil-git-status.nvim",
      dependencies = { "stevearc/oil.nvim" },
      event = "VeryLazy",
      config = function()
         require("oil-git-status").setup({
            show_ignored = false,
         })
      end,
   },

   {
      "akinsho/toggleterm.nvim",
      version = "*",
      event = "VeryLazy",
      config = function()
         require("toggleterm").setup({})
         local Terminal = require("toggleterm.terminal").Terminal
         local fullscreen_float = {
            border = "none",
            width = vim.o.columns,
            height = vim.o.lines,
         }
         local lazygit = Terminal:new({
            cmd = "lazygit",
            direction = "float",
            float_opts = fullscreen_float,
         })
         local vifm = Terminal:new({
            cmd = "vifm .",
            direction = "float",
            float_opts = fullscreen_float,
         })

         vim.keymap.set("n", "<leader>lg", function()
            lazygit:toggle()
         end)
         vim.keymap.set("n", "<leader><leader>e", function()
            vifm:toggle()
         end)
      end,
   },

   { "windwp/nvim-ts-autotag", event = "VeryLazy", opts = {} },
   { "windwp/nvim-autopairs", event = "VeryLazy", opts = {} },
   { "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },
   { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },

   {
      "numToStr/Comment.nvim",
      event = "VeryLazy",
      config = function()
         require("Comment").setup({
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
         })

         vim.keymap.set("n", "<leader>cc", "gcc", { remap = true })
         vim.keymap.set("n", "<leader>cb", "gbc", { remap = true })
         vim.keymap.set("n", "<leader>ca", "gcA", { remap = true })
         vim.keymap.set("n", "<leader>co", "gco", { remap = true })
         vim.keymap.set("n", "<leader>cO", "gcO", { remap = true })

         vim.keymap.set("v", "<leader>c", "gc", { remap = true })
         vim.keymap.set("v", "<leader>b", "gb", { remap = true })
      end,
   },

   {
      "jake-stewart/multicursor.nvim",
      branch = "1.0",
      event = "VeryLazy",
      config = function()
         local mc = require("multicursor-nvim")
         mc.setup({})

         vim.keymap.set({ "n", "v" }, "<c-l>", mc.matchAllAddCursors)
         vim.keymap.set({ "n" }, "<c-n>", "viw")
         vim.keymap.set({ "v" }, "<c-n>", "")
         vim.keymap.set({ "v" }, "n", function()
            mc.matchAddCursor(1)
         end)
         vim.keymap.set({ "v" }, "N", function()
            mc.matchAddCursor(-1)
         end)
         vim.keymap.set({ "v" }, "u", mc.deleteCursor)

         vim.keymap.set("n", "<esc>", function()
            if not mc.cursorsEnabled() then
               mc.enableCursors()
            elseif mc.hasCursors() then
               mc.clearCursors()
            else --[[ <esc> ]]
            end
         end)
      end,
   },

   {
      "mbbill/undotree",
      config = function()
         vim.g.undotree_WindowLayout = 3
         vim.g.undotree_SplitWidth = 38
         vim.g.undotree_ShortIndicators = 0
         vim.g.undotree_DiffAutoOpen = 0
      end,
      keys = {
         { "<leader>tu", "<cmd>UndotreeToggle<cr> | <cmd>UndotreeFocus<cr>" },
      },
   },

   {
      "folke/flash.nvim",
      opts = {
         highlight = { backdrop = true },
         prompt = { enabled = false },
         modes = { char = { enabled = false } },
      },
      keys = {
         {
            "s",
            mode = { "n", "x", "o" },
            function()
               require("flash").jump()
            end,
         },
         {
            "S",
            mode = { "n", "x", "o" },
            function()
               require("flash").treesitter()
            end,
         },
      },
   },

   {
      "ibhagwan/fzf-lua",
      config = function()
         local fzf = require("fzf-lua")
         local img_previewer = { "chafa", "{file}" }

         local function fzf_vertical(command)
            return function()
               require("fzf-lua")[command]({
                  winopts = {
                     preview = {
                        layout = "vertical",
                     },
                  },
               })
            end
         end

         fzf.setup({
            defaults = {
               formatter = "path.filename_first",
            },
            winopts = {
               border = "single",
               backdrop = false,
               title_flags = false,
               fullscreen = true,
               preview = {
                  border = "single",
                  vertical = "down:50%",
                  horizontal = "right:50%",
                  layout = "horizontal",
                  title = false,
                  scrollbar = false,
               },
            },
            previewers = {
               builtin = {
                  extensions = {
                     ["png"] = img_previewer,
                     ["jpg"] = img_previewer,
                     ["jpeg"] = img_previewer,
                     ["gif"] = img_previewer,
                     ["webp"] = img_previewer,
                  },
               },
            },
         })

         vim.keymap.set("n", "<leader>fi", "<cmd>FzfLua files<cr>")
         vim.keymap.set("n", "<leader>fj", "<cmd>FzfLua buffers<cr>")
         vim.keymap.set("n", "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>")
         vim.keymap.set("n", "<leader>fD", "<cmd>FzfLua diagnostics_workspace<cr>")
         vim.keymap.set("n", "<leader>fs", "<cmd>FzfLua spell_suggest<cr>")
         vim.keymap.set("n", "<leader>fo", "<cmd>FzfLua resume<cr>")

         vim.keymap.set("n", "<leader>fg", fzf_vertical("live_grep"))
         vim.keymap.set("n", "<leader>fc", fzf_vertical("grep_curbuf"))
         vim.keymap.set("n", "<leader>fr", fzf_vertical("lsp_references"))
         vim.keymap.set("n", "<leader>fw", fzf_vertical("grep_cword"))
         vim.keymap.set("n", "<leader>fW", fzf_vertical("grep_cWORD"))
      end,
   },

   {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { { "nvim-lua/plenary.nvim" } },
      opts = {
         settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
         },
      },
      keys = function()
         local keys = {
            {
               "<c-m>",
               function()
                  require("harpoon"):list():add()
               end,
            },
            {
               "<tab>",
               function()
                  require("harpoon"):list():prev()
               end,
            },
            {
               "<c-o>",
               function()
                  require("harpoon"):list():next()
               end,
            },
            {
               "<leader>1",
               function()
                  require("harpoon"):list():select(1)
               end,
            },
            {
               "<leader>2",
               function()
                  require("harpoon"):list():select(2)
               end,
            },
            {
               "<leader>3",
               function()
                  require("harpoon"):list():select(3)
               end,
            },
            {
               "<leader>4",
               function()
                  require("harpoon"):list():select(4)
               end,
            },
            {
               "<leader>fk",
               function()
                  local harpoon = require("harpoon")
                  local UI = {
                     title = "",
                     border = "single",
                     ui_width_ratio = 0.6,
                  }
                  harpoon.ui:toggle_quick_menu(harpoon:list(), UI)
               end,
            },
         }
         return keys
      end,
   },

   {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      config = function()
         require("gitsigns").setup({
            preview_config = {
               border = "single",
            },

            on_attach = function(bufnr)
               local gitsigns = require("gitsigns")
               local line = vim.fn.line

               local function map(mode, l, r, opts)
                  opts = opts or {}
                  opts.buffer = bufnr
                  vim.keymap.set(mode, l, r, opts)
               end

               map("n", "<leader>gi", gitsigns.diffthis)
               map("n", "<leader>gI", function()
                  gitsigns.diffthis("~")
               end)

               map("n", "<leader>gj", gitsigns.next_hunk)
               map("n", "<leader>gk", gitsigns.prev_hunk)
               map("n", "<leader>gg", gitsigns.preview_hunk)

               map("n", "<leader>gs", gitsigns.stage_hunk)
               map("n", "<leader>gr", gitsigns.reset_hunk)
               map("n", "<leader>gu", gitsigns.undo_stage_hunk)

               map("v", "<leader>gs", function()
                  gitsigns.stage_hunk({ line("."), line("v") })
               end)
               map("v", "<leader>gr", function()
                  gitsigns.reset_hunk({ line("."), line("v") })
               end)

               map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
               map("n", "<leader>tr", gitsigns.toggle_deleted)

               map("n", "<leader>gb", function()
                  gitsigns.blame_line({ full = true })
               end)
            end,
         })
      end,
   },

   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      event = "BufReadPre",
      config = function()
         require("nvim-treesitter.configs").setup({
            auto_install = true,
            ensure_installed = {
               "javascript",
               "typescript",
               "tsx",
               "html",
               "css",
               "sql",
               "json",
               "jsonc",
               "diff",
               "markdown",
               "markdown_inline",
               "yaml",
               "bash",
               "query",
               "regex",
               "python",
               "lua",
               "vim",
               "vimdoc",
            },
            indent = { enable = true },
            highlight = {
               enable = true,
               additional_vim_regex_highlighting = { "markdown" },
               disable = function(_, bufnr) -- Disable for files with +5K lines
                  return vim.api.nvim_buf_line_count(bufnr) > 5000
               end,
            },
         })
      end,
   },

   {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {
         indent = {
            char = "╎", -- │╎|
            tab_char = "╎",
         },
         scope = {
            enabled = false,
            show_start = false,
            show_end = false,
         },
         exclude = {
            filetypes = { "python" },
         },
      },
   },

   {
      "saghen/blink.cmp",
      build = "cargo build --release",
      dependencies = {
         "L3MON4D3/LuaSnip",
      },
      event = "InsertEnter",
      opts = {
         snippets = {
            preset = "luasnip",
         },
         completion = {
            menu = {
               border = "none",
               auto_show = true,
               draw = {
                  columns = {
                     { "label", "label_description", gap = 1 },
                     { "kind" },
                  },
               },
            },
            documentation = {
               auto_show = false,
               auto_show_delay_ms = 100,
               window = {
                  border = "single",
               },
            },
            accept = {
               auto_brackets = {
                  enabled = false,
               },
            },
         },
         appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono",
         },
         signature = {
            enabled = false,
            window = { border = "single" },
         },
         cmdline = {
            enabled = false,
         },
         keymap = {
            preset = "enter",
            ["<C-Space>"] = { "show_documentation", "hide_documentation" },
         },
      },
      opts_extend = { "sources.default" },
   },

   {
      "neovim/nvim-lspconfig",

      -- npm install -g typescript-language-server -- # ts_ls
      -- npm install -g vscode-langservers-extracted -- # eslint, html, cssls, jsonls
      -- npm install -g @tailwindcss/language-server -- # tailwindcss
      -- pip install pyright -- # pyright

      config = function()
         vim.diagnostic.config({
            virtual_text = false,
            underline = true,
            update_in_insert = false,
            jump = { float = true },
         })

         local open_float = vim.lsp.util.open_floating_preview
         function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = "single"
            return open_float(contents, syntax, opts, ...)
         end

         vim.lsp.config("*", {})
         vim.lsp.enable({
            "ts_ls",
            "eslint",
            "html",
            "cssls",
            "jsonls",
            -- "tailwindcss", -- slow
            "pyright",
         })

         vim.keymap.set("n", "gh", vim.lsp.buf.hover)
         vim.keymap.set("n", "gd", vim.lsp.buf.definition)
         vim.keymap.set("n", "<leader>xx", vim.lsp.buf.code_action)
         vim.keymap.set("n", "<leader>sr", vim.lsp.buf.rename)
         vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
         vim.keymap.set("i", "<c-h>", vim.lsp.buf.signature_help)

         vim.keymap.set("n", "<leader>vj", function()
            vim.diagnostic.jump({ count = 1 })
         end)
         vim.keymap.set("n", "<leader>vk", function()
            vim.diagnostic.jump({ count = -1 })
         end)
      end,
   },

   {
      "stevearc/conform.nvim",

      -- npm install -g prettier
      -- pip install black
      -- brew install stylua

      config = function()
         require("conform").setup({
            formatters_by_ft = {
               javascript = { "prettier" },
               typescript = { "prettier" },
               javascriptreact = { "prettier" },
               typescriptreact = { "prettier" },
               html = { "prettier_html" },
               css = { "prettier" },
               json = { "prettier" },
               markdown = { "prettier" },
               python = { "black" },
               lua = { "stylua" },
            },
            formatters = {
               prettier = {
                  prepend_args = {
                     "--tab-width",
                     "3",
                     "--print-width",
                     "90",
                  },
               },
               prettier_html = {
                  command = "prettier",
                  args = {
                     "--stdin-filepath",
                     "$FILENAME",
                     "--tab-width",
                     "3",
                     "--print-width",
                     "120",
                  },
                  stdin = true,
               },
               black = {
                  prepend_args = {
                     "--line-length",
                     "90",
                  },
               },
               stylua = {
                  prepend_args = {
                     "--indent-type",
                     "Spaces",
                     "--indent-width",
                     "3",
                     "--column-width",
                     "90",
                  },
               },
            },
         })

         vim.keymap.set("n", "<leader>ff", function()
            require("conform").format({
               lsp_fallback = true,
               async = false,
               timeout_ms = 1000,
            })
         end)
      end,
   },
}

-- --------------------------------------------------------------------------------------
-- PLUGIN INSTALLATION
-- --------------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
   local out = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
   })
   if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
         { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
         { out, "WarningMsg" },
         { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
   end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, {
   ui = { border = "single" },
   defaults = {
      lazy = false,
      version = false,
   },
   checker = {
      enabled = true,
      notify = false,
   },
   change_detection = {
      enabled = false,
      notify = false,
   },
   performance = {
      cache = { enabled = true },
      rtp = {
         disabled_plugins = {
            "gzip",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
         },
      },
   },
})

-- --------------------------------------------------------------------------------------
-- COMMANDS
-- --------------------------------------------------------------------------------------
vim.cmd.colorscheme("onedark") -- Default colorscheme

-- Close all buffers except current
vim.api.nvim_create_user_command("BufOnly", function()
   vim.cmd("%bd|e#|bd#")
end, { nargs = 0 })

-- Disable automatic comment continuation
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
   pattern = "*",
   callback = function()
      vim.opt.formatoptions:remove({ "c", "r", "o" })
   end,
})

-- Yank highlighting
local yank = vim.hl.on_yank
vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
   group = "YankHighlight",
   callback = function()
      yank({ higroup = "YankHighlight", timeout = 150 })
   end,
})

-- Fixes 'cmdheight=0' flickering when using InsertMode
vim.api.nvim_create_autocmd("ModeChanged", {
   callback = function()
      if vim.fn.mode() == "i" then
         vim.schedule(vim.cmd.redraw)
      end
   end,
})

-- --------------------------------------------------------------------------------------
-- INDICATORS
-- --------------------------------------------------------------------------------------
-- File changed sign in editor
vim.fn.sign_define("FileChanged", {
   text = "✗",
   texthl = "WarningMsg",
   numhl = "WarningMsg",
})

local function update_sign()
   if vim.bo.filetype:match("^harpoon") then
      return
   end
   local buf, line = vim.api.nvim_get_current_buf(), vim.api.nvim_win_get_cursor(0)[1]

   if vim.bo.modified then
      vim.fn.sign_unplace("user", { buffer = buf })
      vim.fn.sign_place(0, "user", "FileChanged", buf, {
         lnum = line,
         priority = 1,
      })
   else
      vim.fn.sign_unplace("user", { buffer = buf })
   end
end

vim.api.nvim_create_autocmd(
   { "TextChanged", "TextChangedI", "CursorMoved", "CursorMovedI", "BufWritePost" },
   {
      callback = function()
         vim.schedule(update_sign)
      end,
   }
)

-- Macro recording notifications
vim.api.nvim_create_autocmd("RecordingEnter", {
   callback = function()
      print("Recording @" .. vim.fn.reg_recording())
   end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
   callback = function()
      print("Stopped recording")
   end,
})
