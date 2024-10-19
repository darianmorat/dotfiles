-- -------------------------------------------------------------------------------------------
-- MAIN CONFIG
-- -------------------------------------------------------------------------------------------

-- ALIASES
local set = vim.keymap.set
local set_api = vim.api.nvim_set_keymap
local set_hl = vim.api.nvim_set_hl


-- SETTINGS
vim.g.mapleader = " "
vim.opt.syntax = "on"
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.guicursor = "a:block"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 6
vim.opt.colorcolumn = "95"
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 150
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.pumheight = 8
vim.opt.swapfile = false


-- REMAPS
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzz")
set("n", "N", "Nzz")

set("n", "K", "m`i<CR><Esc>``")
set("n", "J", "m`J``")

set("n", "<leader>a", "A")
set("n", "<leader>i", "I")
set("n", "<leader>z", ":ZenMode<CR>")

set("n", "<leader>w", ":w<CR>")
set("n", "<leader>q", ":bd<CR>")
set("n", "<leader><leader>d", ":bd!<CR>")
set("n", "<leader><leader>b", ":BufOnly<CR>")
set("n", "<leader><leader>q", ":q<CR>")

set("n", "<C-k>", ":Lazygit<CR>")
set("n", "<C-j>", ":Vifm<CR>")
set("n", "<C-h>", "<C-6>")

set("n", "<leader>ti", ":IBLToggle<CR>")

set("n", "<leader>ml", ":Lazy load markdown-preview.nvim | :Lazy<CR>")
set("n", "<leader>mp", ":MarkdownPreviewToggle<CR>")

set("v", "K", ":m '<-2<CR>gv=gv")
set("v", "J", ":m '>+1<CR>gv=gv")


-- -------------------------------------------------------------------------------------------
-- PLUGIN LIST
-- -------------------------------------------------------------------------------------------

local plugins = {
-- { "darianmorat/gruvdark-theme.nvim" }, -- Pending
   { "nvim-lualine/lualine.nvim" },
   { "TaDaa/vimade" },
   { "folke/zen-mode.nvim" },
   { "voldikss/vim-floaterm" },
   { "numToStr/Comment.nvim" },
   { "kylechui/nvim-surround", version = "*", event = "VeryLazy" },
   { "jake-stewart/multicursor.nvim", branch = "1.0" },

   { "ggandor/leap.nvim" },
   { "jinh0/eyeliner.nvim" },
   { "nvim-lua/plenary.nvim" },
   { "nvim-telescope/telescope.nvim", tag = "0.1.8" },
   { "ThePrimeagen/harpoon", branch = "harpoon2" },

   { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
   { "nvim-treesitter/nvim-treesitter-refactor" },
   { "windwp/nvim-autopairs", event = "InsertEnter" },
   { "windwp/nvim-ts-autotag" },
   { "lewis6991/gitsigns.nvim" },
   { "lukas-reineke/indent-blankline.nvim", main = "ibl" },

   { "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
   { "williamboman/mason.nvim" },
   { "williamboman/mason-lspconfig.nvim" },
   { "neovim/nvim-lspconfig" },
   { "L3MON4D3/LuaSnip" },
   { "hrsh7th/nvim-cmp" },
   { "hrsh7th/cmp-nvim-lsp" },
   { "hrsh7th/cmp-buffer" },
   { "hrsh7th/cmp-path" },
   { "saadparwaiz1/cmp_luasnip" },
   { "rafamadriz/friendly-snippets" },

   { "iamcco/markdown-preview.nvim", -- Not loaded by default 
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }, 
      build = function() vim.fn["mkdp#util#install"]() end 
   },
}

local gruvdark = require("gruvdark") -- Load theme using gruvdark colors 
vim.list_extend(plugins,gruvdark) -- Merge theme to main plugin list


-- -------------------------------------------------------------------------------------------
-- PLUGIN INSTALLATION
-- -------------------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
   })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins)


-- -------------------------------------------------------------------------------------------
-- PLUGIN CONFIG
-- -------------------------------------------------------------------------------------------

-- LUALINE
local custom = require"lualine.themes.onedark"

custom.normal.a.bg   = "#2B2B2B"
custom.insert.a.bg   = "#2B2B2B"
custom.visual.a.bg   = "#2B2B2B"
custom.command.a.bg  = "#2B2B2B"
custom.replace.a.bg  = "#2B2B2B"
custom.normal.b.bg   = "#2B2B2B"
custom.normal.c.bg   = "#2B2B2B"
custom.inactive.c.bg = "#2B2B2B"

custom.normal.a.fg   = "#CDC5B8"
custom.insert.a.fg   = "#CDC5B8"
custom.visual.a.fg   = "#CDC5B8"
custom.command.a.fg  = "#CDC5B8"
custom.replace.a.fg  = "#CDC5B8"
custom.normal.b.fg   = "#CDC5B8"
custom.normal.c.fg   = "#CDC5B8"

custom.inactive.c.fg = "#555555"

local function dynamic_location()
   local line = vim.fn.line(".")
   local column = vim.fn.col(".")
   return string.format("%d:%d", line, column)
end

require("lualine").setup({
   options = {
      icons_enabled = false,
      theme = custom,
      component_separators = { left = "", right = ""},
      section_separators = { left = "", right = ""}
   },
   sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", { "filename", path = 0 } },
      lualine_c = { { "diff", colored = false } },
      lualine_x = { "selectioncount", { "diagnostics", colored = false } },
      lualine_y = { "encoding", "progress" },
      lualine_z = { dynamic_location }
   },
   inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {}
  },
})


-- VIMADE
require("vimade").setup({
   fadelevel = 0.3
})


-- ZEN-MODE
require("zen-mode").setup({
   window = {
      backdrop = 0.94,
      width = 130,
      height = 1,
      options = {
         signcolumn = "yes",
         number = true,
         relativenumber = true,
         cursorline = false,
         foldcolumn = "0",
         list = false
      }
   }
})


-- FLOATERM
vim.g.floaterm_title = ""
vim.g.floaterm_height = 0.95
vim.g.floaterm_width = 0.6
vim.g.floaterm_position = "top"
vim.g.floaterm_opener = "edit"

vim.cmd("highlight FloatermBorder guibg=#1e1e1e guifg=NONE")
vim.cmd("command! Vifm FloatermNew vifm")
vim.cmd("command! Lazygit FloatermNew --width=0.75 lazygit")


-- COMMENT
require("Comment").setup({})

set("n", "<leader>cc", "gcc", { remap=true })
set("n", "<leader>cb", "gbc", { remap=true })
set("n", "<leader>ca", "gcA", { remap=true })
set("n", "<leader>co", "gco", { remap=true })
set("n", "<leader>cO", "gcO", { remap=true })

set("v", "<leader>c", "gc", { remap=true })
set("v", "<leader>b", "gb", { remap=true })


-- SURROUND
require("nvim-surround").setup({})


-- MULTICURSOR
local mc = require("multicursor-nvim")
mc.setup({})

set({"n", "v"}, "<c-l>", mc.matchAllAddCursors)
set({"n"}, "<c-n>", "viw")
set({"v"}, "<c-n>", "")
set({"v"}, "n", function() mc.matchAddCursor(1) end)
set({"v"}, "N", function() mc.matchAddCursor(-1) end)
set({"v"}, "u", mc.deleteCursor)

set("n", "<esc>", function()
   if not mc.cursorsEnabled() then mc.enableCursors()
   elseif mc.hasCursors() then mc.clearCursors() else end
end)


-- LEAP
require("leap")
set({"n", "x", "o"}, "s", "<Plug>(leap)")
set_hl(0, "LeapLabelPrimary", { fg = "#e1dcd6", bg = "#4c4c4d" })


-- EYELINER
require"eyeliner".setup {
  highlight_on_key = true,
  match = "[0-9a-zA-Z]",
  dim = true
}

set_hl(0, "EyelinerPrimary", { fg="#e1dcd6" })
set_hl(0, "EyelinerSecondary", { fg="#df5a5a" })


-- TELESCOPE
require("telescope").setup({
   defaults = {
      layout_strategy = "vertical",
      layout_config = {
         preview_cutoff = 0,
         width = 0.6,
         preview_height = 0.6
      },
      borderchars = {
         "─", "│", "─", "│", "┌", "┐", "┘", "└"
      },
      file_ignore_patterns = { 
         "node_modules" 
      }
   }
})

local builtin = require("telescope.builtin")
set("n", "<leader>ff", function() builtin.find_files({ previewer = false }) end)
set("n", "<leader>fg", function() builtin.live_grep() end)
set("n", "<leader>fo", function() builtin.resume() end)
set("n", "<leader>fj", function() builtin.buffers({ previewer = false, sort_lastused = true }) end)
set("n", "<leader>fr", function() builtin.lsp_references() end)
set("n", "<leader>fw", function() builtin.grep_string({ search = vim.fn.expand("<cword>") }) end)
set("n", "<leader>fW", function() builtin.grep_string({ search = vim.fn.expand("<cWORD>") }) end)
set("n", "<leader>ej", function() builtin.diagnostics({ bufnr = 0 }) end)


-- HARPOON
local harpoon = require("harpoon")
local toggle_opts = {
   border = "single",
   title_pos = "center",
   ui_width_ratio = 0.50
}

harpoon:setup({})

set("n", "<c-m>", function() harpoon:list():add() end)
set("n", "<leader>fk", function() harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts) end)
set("n", "<tab>", function() harpoon:list():prev() end) -- Tab refers <c-i>
set("n", "<c-o>", function() harpoon:list():next() end)

set("n", "<leader>1", function() harpoon:list():select(1) end)
set("n", "<leader>2", function() harpoon:list():select(2) end)
set("n", "<leader>3", function() harpoon:list():select(3) end)
set("n", "<leader>4", function() harpoon:list():select(4) end)


-- TREESIETER
require"nvim-treesitter.configs".setup({
   ensure_installed = {
      "lua", "javascript", "typescript", "tsx", "html", "css", "json", "markdown"
   },
   sync_install = false,
   indent = {
      enable = true
   },
   highlight = {
      enable = true,  
      additional_vim_regex_highlighting = {
         "markdown" 
      },
   }
})


-- TREESIETER REFACTOR
require"nvim-treesitter.configs".setup({
   refactor = {
      highlight_definitions = {
         enable = true,
         clear_on_cursor_move = true
      },
      smart_rename = {
         enable = true,
         keymaps = {
           smart_rename = "<leader>er"
         }
      }
   }
})


-- AUTOPAIRS
require("nvim-autopairs").setup({})


-- AUTOTAG
require("nvim-ts-autotag").setup({})


-- GITSIGNS
require("gitsigns").setup({
   on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, opts)
         opts = opts or {}
         opts.buffer = bufnr
         vim.keymap.set(mode, l, r, opts)
      end

      -- Fix 'quit' when using .diffthis
      local function smart_quit()
         if vim.wo.diff then 
            vim.cmd("wincmd p | q") 
         else 
            vim.cmd(":bd") 
         end
      end

      -- Actions
      map("n", "<leader><leader>gi", gitsigns.diffthis)
      map("n", "<leader>gi", function() gitsigns.diffthis("~") end)
      map("n", "<leader>q", smart_quit)

      map("n", "<leader>gj", gitsigns.next_hunk)
      map("n", "<leader>gk", gitsigns.prev_hunk)
      map("n", "<leader>gg", gitsigns.preview_hunk)

      map("n", "<leader>gs", gitsigns.stage_hunk)
      map("n", "<leader>gr", gitsigns.reset_hunk)
      map("v", "<leader>gs", function() gitsigns.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
      map("v", "<leader>gr", function() gitsigns.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
      map("n", "<leader>gu", gitsigns.undo_stage_hunk)

      map("n", "<leader>gb", function() gitsigns.blame_line{full=true} end)
      map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
      map("n", "<leader>tr", gitsigns.toggle_deleted)
   end
})


-- LINE INDENTATION
require("ibl").setup({
   indent = {
      char = "|", -- "│"
      tab_char = "|", -- "│"
   },
   scope = { 
      enabled = true,
      show_start = false,
      show_end = false
   }
})


-- LSP-ZERO
local lsp_zero = require("lsp-zero")
local lsp_attach = function(client, bufnr)
   local b_opts = {buffer = bufnr}
   set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", b_opts)
   set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", b_opts)
   set("n", "<leader>ef", "<cmd>lua vim.lsp.buf.code_action()<cr>", b_opts)
end

lsp_zero.extend_lspconfig({
   sign_text = true,
   lsp_attach = lsp_attach,
   capabilities = require("cmp_nvim_lsp").default_capabilities()
})


-- MASON: 9
-- [css-lsp] [emmet-language-server] [eslint-lsp] [html-lsp]
-- [json-lsp] [marksman] [prettierd] [stylelint] [typescript-language-server]

require("mason").setup({})
require("mason-lspconfig").setup({
   handlers = {
      function(server_name)
         require("lspconfig")[server_name].setup({})
      end
   }
})


-- CMP
local cmp = require("cmp")
local cmp_action = lsp_zero.cmp_action()
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
   completion = { 
      completeopt = "menu,menuone,noinsert"  -- Select first suggestion
   },
   sources = { 
   -- Mimic vscode suggestions
      {name = "nvim_lsp"},
      {name = "buffer", keyword_length = 2},
      {name = "luasnip", keyword_length = 2},
      {name = "path"}
   },
   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end
   },
   view = { docs = { auto_open = false } }, -- Docs closed by default
   mapping = cmp.mapping.preset.insert({ 
      ["<Enter>"] = cmp.mapping.confirm({ select = true }),
      ["<C-Space>"] = cmp.mapping(function() -- Double press due TMUX (same vscode)
         if cmp.visible_docs() then cmp.close_docs() else cmp.open_docs() end
      end)
   }),
   formatting = lsp_zero.cmp_format({details = false})
})


-- AUTO-COMMANDS
vim.cmd("command BufOnly silent! execute '%bd|e#|bd#'") -- Close all buffers except current
vim.cmd("autocmd CursorHold * echon ''") -- Clear command line - uses 'updatetime' value - FIND WAY TO TOGGLE IT 
vim.cmd("highlight incsearch guibg=#5c5c5e guifg=#e6e3de") -- Set bg color for search / ?

-- Yank highlighting
vim.cmd("autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup='YankHighlight', timeout=190}")
vim.cmd("highlight YankHighlight guibg=#2b2b2b guifg=#e6e3de")

-- No auto-comment when using motions like 'o'
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- Rename tmux window
vim.cmd([[autocmd VimEnter * silent !tmux rename-window "nvim"]])
vim.cmd([[autocmd VimLeave * silent !tmux rename-window "tmux"]])
