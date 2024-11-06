-- -------------------------------------------------------------------------------------------
-- MAIN CONFIG
-- -------------------------------------------------------------------------------------------

-- SETTINGS
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.wrap = false

vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.cmdheight = 0
vim.opt.pumheight = 8

vim.opt.mouse = ""
vim.opt.updatetime = 50
vim.opt.ruler = false

vim.opt.guicursor = "a:block"
vim.opt.cursorline = false
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.opt.softtabstop = 3

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true

vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 6
vim.opt.colorcolumn = "95"
vim.opt.signcolumn = "yes"

vim.opt.spell = false
vim.opt.spelllang = "en_us"
vim.opt.spelloptions="camel"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.g.markdown_recommended_style = 0

vim.schedule(function()
   vim.opt.clipboard = "unnamedplus"
end)


-- REMAPS
local set = vim.keymap.set
local silent = { silent = true }

local function smart_quit() -- Fix quit in diff
   if vim.wo.diff then vim.cmd("wincmd p | q") 
   else vim.cmd(":q") end
end

set("n", "<leader>q", smart_quit)
set("n", "<leader>w", ":silent w<cr>", silent)
set("n", "<leader>d", "<cmd>bd<cr>")
set("n", "<leader><leader>d", "<cmd>bd!<cr>")
set("n", "<leader><leader>b", "<cmd>BufOnly<cr>")

set("n", "n", "nzz")
set("n", "N", "Nzz")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")

set("n", "K", "m`i<cr><Esc>``")
set("n", "J", "m`J``")

set("n", "<C-h>", "<C-6>")
set("n", "=ap", "m`=ap``")
set("n", "<leader>a", "A")
set("n", "<leader>i", "I")

set("n", "<leader>e", "<cmd>FloatermNew vifm<cr>")
set("n", "<leader>lg", "<cmd>FloatermNew --width=0.75 lazygit<cr>")

set("n", "<leader>tI", "<cmd>IBLToggle<cr>")
set("n", "<leader>ti", "m`<cmd>ToggleScope<CR> | <cmd>IBLToggle<cr>``")
set("n", "<leader>ts", "<cmd>set spell!<cr>")
set("n", "<leader>tn", "<cmd>set relativenumber!<cr>")
set("n", "<leader>tw", "<cmd>set wrap!<cr>")
set("n", "<leader>tu", "<cmd>UndotreeToggle<cr> | <cmd>UndotreeFocus<cr> ")

set("n", "<leader>tm", "<cmd>MarkdownPreviewToggle<cr>")
set("n", "<leader><leader>tm", "<cmd>Lazy load markdown-preview.nvim<cr> | <cmd>Lazy<cr>")

set("n", "<leader>r", "<cmd>LspRestart<cr>")

set("v", "<", "<gv")
set("v", ">", ">gv")
set("v", "K", ":m '<-2<cr>gv=gv")
set("v", "J", ":m '>+1<cr>gv=gv")


-- -------------------------------------------------------------------------------------------
-- PLUGIN LIST
-- -------------------------------------------------------------------------------------------

local plugins = {
   { "dstein64/vim-startuptime", cmd = "StartupTime",
      init = function() vim.g.startuptime_tries = 20 end
   },
   
   -- In first install use :Lazy build markdown-preview.nvim
   { "iamcco/markdown-preview.nvim", cmd = { "MarkdownPreviewToggle" } },

   { "nvim-lualine/lualine.nvim", lazy = true },
   { "TaDaa/vimade", lazy = true },
   { "voldikss/vim-floaterm", cmd = "FloatermNew" },

   { "numToStr/Comment.nvim", event = "VeryLazy" },
   { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
   { "kylechui/nvim-surround", version = "*", event = "VeryLazy" },
   { "jake-stewart/multicursor.nvim", branch = "1.0", event = "VeryLazy" },
   { "mbbill/undotree", cmd = "UndotreeToggle" },

   { "ggandor/leap.nvim", lazy = true },
   { "nvim-telescope/telescope.nvim", tag = "0.1.8", cmd = "Telescope",
      dependencies = { { "nvim-lua/plenary.nvim", lazy = true } }
   },
   { "ThePrimeagen/harpoon", branch = "harpoon2", event = "VeryLazy",
      dependencies = { { "nvim-lua/plenary.nvim", lazy = true } }
   },

   { "lewis6991/gitsigns.nvim", event = "VeryLazy" },
   { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = "BufReadPre" },
   { "windwp/nvim-ts-autotag", event = { "InsertEnter" } },
   { "windwp/nvim-autopairs", event = { "InsertEnter" } },
   { "lukas-reineke/indent-blankline.nvim", main = "ibl", event = "VeryLazy" },
   { "echasnovski/mini.indentscope", version = "*", event = "VeryLazy" },

   { "neovim/nvim-lspconfig", lazy = true,
      dependencies = {
         { "williamboman/mason.nvim" },
         { "williamboman/mason-lspconfig.nvim" },
      }
   },

   { "hrsh7th/nvim-cmp", event = "InsertEnter",
      dependencies = {
         { "L3MON4D3/LuaSnip", dependencies = {
               "rafamadriz/friendly-snippets"
            }
         },
         { "hrsh7th/cmp-nvim-lsp" },
         { "hrsh7th/cmp-path" },
         { "hrsh7th/cmp-buffer" },
         { "saadparwaiz1/cmp_luasnip" }
      } 
   }
}

local themes = require("themes") -- Load themes - GruvDark reference
vim.list_extend(plugins,themes) -- Merge themes to main plugin list


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
      lazypath
   })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins, {
   ui = { border = "single" }
})


-- -------------------------------------------------------------------------------------------
-- PLUGIN CONFIG
-- -------------------------------------------------------------------------------------------

-- COLORS
vim.cmd("colorscheme onedark")
set("n", "<leader>cs", "<cmd>Telescope colorscheme<cr>")
set("n", "<leader>ch", "<cmd>Telescope highlights<cr>")


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

function harpoon_marks()
   local hp_list = require("harpoon"):list()
   local total_marks = hp_list:length()

   if total_marks == 0 then return "" end

   local full_name = vim.api.nvim_buf_get_name(0)
   local buffer_name = vim.fn.expand("%")
   local output = { "M:" }

   for index = 1, math.min(total_marks, 4) do
      local mark = hp_list.items[index].value
      if mark == buffer_name or mark == full_name then
         table.insert(output, "*")
      else table.insert(output, index) end
   end

   return table.concat(output, "")
end

function dynamic_progress()
   local current_line = vim.fn.line(".")
   local total_lines = vim.fn.line("$")
   local progress_percentage = math.floor((current_line / total_lines) * 100)

   if current_line == 1 then return "Top"
   elseif progress_percentage == 100 then return "Bot"
   else
      return string.format("%02d", progress_percentage).. "%%"
   end
end

function dynamic_location()
   local line = vim.fn.line(".")
   local column = vim.fn.col(".")

   return string.format("%d:%d", line, column)
end

function custom_text()
   return "×"
end

require("lualine").setup({
   options = {
      icons_enabled = false,
      theme = custom,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" }
   },
   sections = {
      lualine_a = { "mode", custom_text },
      lualine_b = { "branch", { "filename", path = 0, symbols = { modified = "-[[+]]" } } },
      lualine_c = { { "diff", colored = false } },
      lualine_x = { "selectioncount", { "diagnostics", colored = false } },
      lualine_y = { harpoon_marks, dynamic_progress, dynamic_location },
      lualine_z = { custom_text, "hostname" }
   },
   inactive_sections = {
      lualine_c = { "filename" },
      lualine_x = { "location" }
   }
})


-- VIMADE
require("vimade").setup({
   fadelevel = 0.3,
   blocklist = {
      only_behind_float_windows = function (win, current)
         if (win.win_config.relative == "") and 
            (current and current.win_config.relative ~= "") then
            return false end
         return true
      end
   }
})


-- FLOATERM
vim.g.floaterm_title = ""
vim.g.floaterm_height = 0.95
vim.g.floaterm_width = 0.6
vim.g.floaterm_position = "top"
vim.g.floaterm_opener = "edit"


-- COMMENT
require("Comment").setup({
   pre_hook = require(
      "ts_context_commentstring.integrations.comment_nvim"
   ).create_pre_hook()
})

set("n", "<leader>cc", "gcc", { remap = true })
set("n", "<leader>cb", "gbc", { remap = true })
set("n", "<leader>ca", "gcA", { remap = true })
set("n", "<leader>co", "gco", { remap = true })
set("n", "<leader>cO", "gcO", { remap = true })

set("v", "<leader>c", "gc", { remap = true })
set("v", "<leader>b", "gb", { remap = true })


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
   elseif mc.hasCursors() then mc.clearCursors() 
   else --[[ <esc> ]] end
end)


-- UNDOTREE
vim.g.undotree_WindowLayout = 3
vim.g.undotree_SplitWidth = 38
vim.g.undotree_ShortIndicators = 0
vim.g.undotree_DiffAutoOpen = 0


-- LEAP
require("leap").setup({})
set({"n", "x", "o"}, "s", "<Plug>(leap)")


-- TELESCOPE
local tb = require("telescope.builtin")
local actions = require("telescope.actions")

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
      },
      mappings = {
         i = {
            [ "<esc>" ] = actions.close
         }
      }
   },
   pickers = {
      buffers = {
         sort_lastused = true,
         ignore_current_buffer = true
      }
   }
})

set("n", "<leader>ff", function() tb.find_files({ previewer = false }) end)
set("n", "<leader>fg", function() tb.live_grep() end)
set("n", "<leader>fo", function() tb.resume() end)
set("n", "<leader>fj", function() tb.buffers({ previewer = false }) end)
set("n", "<leader>fw", function() tb.grep_string({ search = vim.fn.expand("<cword>") }) end)
set("n", "<leader>fW", function() tb.grep_string({ search = vim.fn.expand("<cWORD>") }) end)

set("n", "<leader>fr", function() tb.lsp_references() end)
set("n", "<leader>fd", function() tb.diagnostics({ bufnr = 0 }) end)


-- HARPOON
local hp = require("harpoon")
local toggle_opts = {
   border = "single",
   title_pos = "center",
   ui_width_ratio = 0.60
}

hp:setup({})

-- Fix: Doesn't close the [No Name] buffer as Telescope
local is_first_run = true 
local function handler()
   if is_first_run then vim.cmd("bd 1") is_first_run = false end
end

set("n", "<c-m>", function() hp:list():add() end)
set("n", "<leader>fk", function() hp.ui:toggle_quick_menu(hp:list(), toggle_opts) end)

set("n", "<tab>", function() hp:list():prev() handler() end) -- Key <c-i>
set("n", "<c-o>", function() hp:list():next() handler() end)
set("n", "<leader>1", function() hp:list():select(1) handler() end)
set("n", "<leader>2", function() hp:list():select(2) handler() end)
set("n", "<leader>3", function() hp:list():select(3) handler() end)
set("n", "<leader>4", function() hp:list():select(4) handler() end)


-- GITSIGNS
require("gitsigns").setup({
   on_attach = function(bufnr)
      local gs = require("gitsigns")
      local ln = vim.fn.line

      local function map(mode, l, r, opts)
         opts = opts or {}
         opts.buffer = bufnr
         vim.keymap.set(mode, l, r, opts)
      end

      map("n", "<leader><leader>gi", gs.diffthis)
      map("n", "<leader>gi", function() gs.diffthis("~") end)

      map("n", "<leader>gj", gs.next_hunk)
      map("n", "<leader>gk", gs.prev_hunk)
      map("n", "<leader>gg", gs.preview_hunk)

      map("n", "<leader>gs", gs.stage_hunk)
      map("n", "<leader>gr", gs.reset_hunk)
      map("v", "<leader>gs", function() gs.stage_hunk{ ln("."), ln("v") } end)
      map("v", "<leader>gr", function() gs.reset_hunk{ ln("."), ln("v") } end)
      map("n", "<leader>gu", gs.undo_stage_hunk)

      map("n", "<leader>gb", function() gs.blame_line{ full = true } end)
      map("n", "<leader>tb", gs.toggle_current_line_blame)
      map("n", "<leader>tr", gs.toggle_deleted)
   end
})


-- TREESITTER
require"nvim-treesitter.configs".setup({
   ensure_installed = {
      "lua", "javascript", "typescript", "tsx", "html", "css",
      "json", "jsonc", "diff", "markdown", "markdown_inline", "yaml", "query"
   },
   sync_install = false,
   indent = {
      enable = true
   },
   highlight = {
      enable = true,  
      additional_vim_regex_highlighting = {
         "markdown" 
      }
   }
})


-- AUTOTAG
require("nvim-ts-autotag").setup({})


-- AUTOPAIRS
require("nvim-autopairs").setup({})


-- LINE INDENTATION
require("ibl").setup({
   indent = {
      char = "╎", -- │╎|
      tab_char = "╎"
   },
   scope = {
      enabled = false,
      show_start = false,
      show_end = false
   }
})


-- SCOPE INDENTATION
require("mini.indentscope").setup({
   symbol = "╎", -- │╎|
   draw = {
      delay = 0,
      animation = function()
         return 0
      end
   }
})


-- LSP
local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_lsp.default_capabilities()

local lsp_attach = function(client, bufnr)
   local opts = { buffer = bufnr }
   set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
   set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
   set("n", "<leader>xx", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
   set("n", "<leader>sr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
   vim.lsp.handlers.hover, { border = "single" }
)


-- MASON: 8
-- [css-lsp] [eslint-lsp] [html-lsp] [json-lsp] [marksman]
-- [prettierd] [stylelint] [typescript-language-server]

require("mason").setup({
   ui = { border = "single" }
})
require("mason-lspconfig").setup({
   handlers = {
      function(server_name)
         require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = lsp_attach
         })
      end
   }
})


-- CMP
local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").filetype_extend("javascriptreact", { "html" })

cmp.setup({
   completion = { 
      completeopt = "menu, menuone, noinsert"  
   },
   sources = { 
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
      { name = "buffer" },
   },
   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end
   },
   view = {
      docs = { auto_open = false }
   },
   window = {
      documentation = {
         winhighlight = "Normal:MatchParen,FloatBorder:MatchParen",
      }
   },
   mapping = cmp.mapping.preset.insert({ 
      ["<Enter>"] = cmp.mapping.confirm({ select = true }),
      ["<C-z>"] = cmp.mapping(function() -- C-Space x2, WezTerm binding
         if cmp.visible_docs() then cmp.close_docs() 
         else cmp.open_docs() end
      end)
   })
})


-- COMMANDS
vim.cmd("command BufOnly silent! execute '%bd|e#|bd#'") -- Close all others buffers
vim.cmd("autocmd BufNewFile,BufRead * setlocal formatoptions-=cro") -- No auto-comments

-- Yank highlighting
vim.cmd("highlight YankHighlight guibg=#2b2b2b guifg=#e6e3de")
local yank = vim.highlight.on_yank

vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", { group = "YankHighlight",
   callback = function() yank({ higroup = "YankHighlight", timeout = 190 }) end
})

-- Indentation CMDs
vim.cmd("command! ToggleScope lua ToggleScope()")
function ToggleScope()
   vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
end

require("ibl").overwrite { -- Disable Line Indentation
   exclude = { filetypes = { "help", "undotree" } }
}

vim.api.nvim_create_autocmd({ "FileType" }, { -- Disable Scope Indentation
   callback = function()
      local ignore_filetypes = {
         "help", "lazy", "mason", "undotree", "startuptime" 
      }
      if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
         vim.b.miniindentscope_disable = true
      end
   end
})
