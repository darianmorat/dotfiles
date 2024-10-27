-- -------------------------------------------------------------------------------------------
-- MAIN CONFIG
-- -------------------------------------------------------------------------------------------

-- SETTINGS
vim.g.mapleader = " "
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.cmdheight = 1
vim.opt.pumheight = 8
vim.opt.guicursor = "a:block"
vim.opt.cursorline = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.termguicolors = true

vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 6
vim.opt.colorcolumn = "95"
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 120
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.g.markdown_recommended_style = 0


-- REMAPS
local set = vim.keymap.set

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
set("n", "<leader>tn", ":set relativenumber!<CR>")

set("n", "<leader>tm", ":MarkdownPreviewToggle<CR>")
set("n", "<leader><leader>m", ":Lazy load markdown-preview.nvim | :Lazy<CR>")

set("v", "K", ":m '<-2<CR>gv=gv")
set("v", "J", ":m '>+1<CR>gv=gv")

set("v", "<", "<gv")
set("v", ">", ">gv")


-- -------------------------------------------------------------------------------------------
-- PLUGIN LIST
-- -------------------------------------------------------------------------------------------

local plugins = {
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
   { "echasnovski/mini.indentscope", version = "*" },

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
   }
}

local colors = require("colors") -- Load colors - gruvdark reference
vim.list_extend(plugins,colors) -- Merge colors to main plugin list


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
   ui = {
      border = "single"
   }
})


-- -------------------------------------------------------------------------------------------
-- PLUGIN CONFIG
-- -------------------------------------------------------------------------------------------

-- COLORS
vim.cmd("colorscheme onedark")
set("n", "<leader>cs", ":Telescope colorscheme<CR>")
set("n", "<leader>ch", ":Telescope highlights<CR>")


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

  if total_marks == 0 then
    return ""
  end

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

function dynamic_location()
   local line = vim.fn.line(".")
   local column = vim.fn.col(".")
   return string.format("%d:%d", line, column)
end

function custom_text()
   return "NEOVIM"
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
      lualine_y = { harpoon_marks, "progress" }, -- Dinamic_progress: use 2 digits 08%
      lualine_z = { dynamic_location, custom_text }
   },
   inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {}
   }
})


-- VIMADE
require("vimade").setup({
   fadelevel = 0.3
})


-- ZEN-MODE
require("zen-mode").setup({
   window = {
      backdrop = 0.90,
      width = 125,
      height = 1,
      options = {
         signcolumn = "yes",
         relativenumber = true,
         number = true,
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
   elseif mc.hasCursors() then mc.clearCursors() 
   else --[[ <esc> ]] end
end)


-- LEAP
require("leap").setup({})
set({"n", "x", "o"}, "s", "<Plug>(leap)")


-- EYELINER
require("eyeliner").setup({
  highlight_on_key = true,
  match = "[0-9a-zA-Z]",
  dim = true
})


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
   }
})

set("n", "<leader>ff", function() tb.find_files({ previewer=false }) end)
set("n", "<leader>fg", function() tb.live_grep() end)
set("n", "<leader>fo", function() tb.resume() end)
set("n", "<leader>fj", function() tb.buffers({ previewer=false,sort_lastused=true }) end)
set("n", "<leader>fr", function() tb.lsp_references() end)
set("n", "<leader>fw", function() tb.grep_string({ search=vim.fn.expand("<cword>") }) end)
set("n", "<leader>fW", function() tb.grep_string({ search=vim.fn.expand("<cWORD>") }) end)
set("n", "<leader>ej", function() tb.diagnostics({ bufnr=0 }) end)


-- HARPOON
local hp = require("harpoon")
local toggle_opts = {
   border = "single",
   title_pos = "center",
   ui_width_ratio = 0.50
}

hp:setup({})

set("n", "<c-m>", function() hp:list():add() end)
set("n", "<leader>fk", function() hp.ui:toggle_quick_menu(hp:list(), toggle_opts) end)
set("n", "<tab>", function() hp:list():prev() end) -- Tab refers <c-i>
set("n", "<c-o>", function() hp:list():next() end)

set("n", "<leader>1", function() hp:list():select(1) end)
set("n", "<leader>2", function() hp:list():select(2) end)
set("n", "<leader>3", function() hp:list():select(3) end)
set("n", "<leader>4", function() hp:list():select(4) end)


-- TREESIETER
require"nvim-treesitter.configs".setup({
   ensure_installed = {
      "lua", "javascript", "typescript", "tsx", "python",
      "regex", "xml", "html", "css", "json", "jsonc", 
      "diff", "markdown", "markdown_inline", "yaml", "query"
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
      local gs = require("gitsigns")
      local ln = vim.fn.line

      local function map(mode, l, r, opts)
         opts = opts or {}
         opts.buffer = bufnr
         vim.keymap.set(mode, l, r, opts)
      end

      -- Fix 'quit' when using .diffthis
      local function smart_quit()
         if vim.wo.diff then vim.cmd("wincmd p | q") 
         else vim.cmd(":bd") end
      end

      -- Actions
      map("n", "<leader><leader>gi", gs.diffthis)
      map("n", "<leader>gi", function() gs.diffthis("~") end)
      map("n", "<leader>q", smart_quit)

      map("n", "<leader>gj", gs.next_hunk)
      map("n", "<leader>gk", gs.prev_hunk)
      map("n", "<leader>gg", gs.preview_hunk)

      map("n", "<leader>gs", gs.stage_hunk)
      map("n", "<leader>gr", gs.reset_hunk)
      map("v", "<leader>gs", function() gs.stage_hunk{ ln("."),ln("v") } end)
      map("v", "<leader>gr", function() gs.reset_hunk{ ln("."),ln("v") } end)
      map("n", "<leader>gu", gs.undo_stage_hunk)

      map("n", "<leader>gb", function() gs.blame_line{ full=true } end)
      map("n", "<leader>tb", gs.toggle_current_line_blame)
      map("n", "<leader>tr", gs.toggle_deleted)
   end
})


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
      delay = 10,
      animation = function()
         return 10
      end
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

require("mason").setup({
   ui = {
      border = "single"
   }
})
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
   -- Select first menu suggestion
      completeopt = "menu,menuone,noinsert"  
   },
   sources = { 
   -- Suggestions order: vscode-like
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
   view = {
      docs = { auto_open = false }
   },
   mapping = cmp.mapping.preset.insert({ 
      ["<Enter>"] = cmp.mapping.confirm({ select = true }),
      ["<C-z>"] = cmp.mapping(function() -- C-Space x2, WezTerm binding
         if cmp.visible_docs() then cmp.close_docs() 
         else cmp.open_docs() end
      end)
   }),
   formatting = lsp_zero.cmp_format({details = false})
})


-- AUTO-COMMANDS
vim.cmd("command BufOnly silent! execute '%bd|e#|bd#'") -- Close all others buffers
vim.cmd("autocmd CursorHold * echon ''") -- Clear command line, use updatetime

-- No auto-comment when using motions like 'o'
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- Yank highlighting
vim.cmd("highlight YankHighlight guibg=#2b2b2b guifg=#e6e3de")
local yank = vim.highlight.on_yank

vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", { group = "YankHighlight",
   callback = function() yank({ higroup = "YankHighlight", timeout = 190 }) end
})
