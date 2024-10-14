-- -------------------------------------------------------------------------------------------
-- MAIN CONFIG
-- -------------------------------------------------------------------------------------------

-- ALIASES
local set = vim.keymap.set
local set_hl = vim.api.nvim_set_hl
local set_api = vim.api.nvim_set_keymap

local p_opts = { silent=true, noremap=true }
local p_opt = { remap=true }


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
vim.opt.updatetime = 200
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.pumheight = 8


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

set("n", "<C-k>", ":FloatermNew lazygit<CR>")
set("n", "<C-j>", ":FloatermNew vifm<CR>")
set("n", "<C-h>", "<C-6>")

set("v", "K", ":m '<-2<CR>gv=gv")
set("v", "J", ":m '>+1<CR>gv=gv")


-- -------------------------------------------------------------------------------------------
-- PLUGIN LIST
-- -------------------------------------------------------------------------------------------

local plugins = {
	{ "navarasu/onedark.nvim" },
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
}


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
-- GRUVDARK THEME
-- -------------------------------------------------------------------------------------------

require("onedark").setup({
   style = "warmer", code_style = { comments = "none" },
   colors = {
      black = "#1B1B1B", grey = "#646464",
      fg = "#CDC5B8", blue = "#5b98c9", red = "#DB6A6A",
      yellow = "#D19F66", green = "#76B568", cyan = "#CDC5B8",
      purple = "#CD60B9", aqua = "#4DB0BD", orange = "#D19F66",
   },
   highlights = {
      Folded = { fg = "#CDC5B8", bg = "#282828" },
      FloatBorder = { fg = "#CDC5B8", bg = "#1E1E1E" }, -- Harpoon UI
      NormalFloat = { fg = "#CDC5B8", bg = "#1E1E1E" }, -- Harpoon UI
      Normal = { bg= "#1E1E1E" }, CursorLine = { bg = "#303030" },
      Visual = { bg = "#353535" }, TelescopeSelection = { bg = "#303030"},
      TSParameter = { fg = "$fg" }, TSParameterReference = { fg = "$fg" }, 
      LineNr = { fg = "#555555" },

      ["@comment"] = { fg = '#555555' },
      ["@operator"] = { fg = '$blue' },
      ["@punctuation"] = { fg = '$fg' },
      ["@punctuation.bracket"] = { fg = '$fg' },
      ["@variable"] = {fg = '$fg'},
      ["@variable.member"] = {fg = "$fg"},
      ["@variable.parameter"] = {fg = "$fg"},
      ["@lsp.type.typeParameter"] = {fg = "$fg"},
      ["@lsp.type.parameter"] = {fg = "$fg"},
      ["@function"] = {fg = "$red"},
      ["@function.method"] = {fg = "$red"},
      ["@constructor"] = {fg = "$blue"},
      ["@keyword"] = {fg = "$blue"},
      ["@variable.builtin"] = {fg = "$yellow"},
      ["@type"] = {fg = "$aqua"},
      ["@type.builtin"] = {fg = "$aqua"},
      ["@tag"] = {fg = "$red"},
      ["@tag.delimiter"] = {fg = "$red"},
      ["@tag.attribute"] = {fg = "#9266DA"},
      ["@markup.heading"] = {fg = "$fg", fmt = "none"},
      ["@property.css"] = { fg = "$blue" },  
      ["@string.css"] = { fg = "$yellow" },  
      ["@tag.css"] = { fg = "$red" },  
      ["@type.css"] = { fg = "$red" },  
      ["@operator.css"] = { fg = "$red" },  
      ["@attribute.css"] = { fg = "$red" },  
   }
}) require("onedark").load()

vim.cmd("highlight Comment gui=NONE")
vim.cmd("highlight IblIndent guifg=#2f2f2f")
vim.cmd("highlight EndOfBuffer guibg=NONE guifg=#2f2f2f ctermbg=NONE")
vim.cmd("highlight SignColumn ctermbg=NONE guibg=NONE")
vim.cmd("highlight ColorColumn guibg=#222222")

local onedark = require"lualine.themes.onedark"
onedark.normal.a.bg = "#292929" onedark.normal.a.fg = "#CDC5B8"
onedark.insert.a.bg = "#292929" onedark.insert.a.fg = "#CDC5B8"
onedark.visual.a.bg = "#292929" onedark.visual.a.fg = "#CDC5B8"
onedark.command.a.bg = "#292929" onedark.command.a.fg = "#CDC5B8"

onedark.normal.b.bg = "#292929" onedark.normal.b.fg = "#CDC5B8"
onedark.normal.c.bg = "#292929" onedark.normal.c.fg = "#CDC5B8"
onedark.inactive.c.bg = "#292929" onedark.inactive.c.fg = "#555555"


-- -------------------------------------------------------------------------------------------
-- PLUGIN CONFIG
-- -------------------------------------------------------------------------------------------

-- LUALINE
local function dynamic_location()
   local line = vim.fn.line(".")
   local column = vim.fn.col(".")
   return string.format("%d:%d", line, column)
end

require("lualine").setup({
   options = {
      icons_enabled = false,
      theme = onedark,
      component_separators = { left = "", right = ""},
      section_separators = { left = "", right = ""}
   },
   sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", { "filename", path = 0 } },
      lualine_c = { { "diff", colored = false } },
      lualine_x = { "selectioncount", { "diagnostics", colored = false } },
      lualine_y = { "fileformat", "encoding", "progress" },
      lualine_z = { dynamic_location }
   }
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


-- COMMENT
require("Comment").setup({})

set("n", "<leader>cc", "gcc", p_opt)
set("n", "<leader>cb", "gbc", p_opt)
set("n", "<leader>ca", "gcA", p_opt)
set("n", "<leader>co", "gco", p_opt)
set("n", "<leader>cO", "gcO", p_opt)

set("v", "<leader>c", "gc", p_opt)
set("v", "<leader>b", "gb", p_opt)


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
      border = {
         prompt  = { 1, 1, 1, 1 },
         results = { 1, 1, 1, 1 },
         preview = { 1, 1, 1, 1 }
      },
      borderchars = {
         results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
         preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
         prompt  = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
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
local toggle_opts = { border = "single", title_pos = "center", ui_width_ratio = 0.50 }
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
   ensure_installed = {"vim", "lua", "javascript", "typescript", "tsx", "html", "css", "json", "markdown"},
   sync_install = false,
   indent = {
      enable = true
   },
   highlight = {
      enable = true,  
      additional_vim_regex_highlighting = false
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
require("gitsigns").setup({})
set_api("n", "<leader>gi", "<cmd>lua require('gitsigns').preview_hunk_inline()<CR>", p_opts)
set_api("n", "<leader>gj", "<cmd>lua require('gitsigns').next_hunk()<CR>", p_opts)
set_api("n", "<leader>gk", "<cmd>lua require('gitsigns').prev_hunk()<CR>", p_opts)


-- LINE INDENTATION
require("ibl").setup({
   indent = { char = "|" },
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
   completion = { completeopt = "menu,menuone,noinsert" }, -- Select first suggestion
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
