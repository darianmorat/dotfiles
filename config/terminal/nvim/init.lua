-- --------------------------------------------------------------------------------------
-- SETTINGS
-- --------------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.pumheight = 8

vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.cmdheight = 0
vim.opt.laststatus = 0

vim.opt.updatetime = 150
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = false

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
vim.opt.showtabline = 0
vim.g.markdown_recommended_style = 0

vim.opt.fillchars = { eob = " " }
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
vim.keymap.set("n", "=ap", "m`=ap``")

vim.keymap.set("n", "<leader>a", "A")
vim.keymap.set("n", "<leader>i", "I")
vim.keymap.set("n", "<leader>p", "<c-g>")

vim.keymap.set("n", "<leader>ti", "<cmd>IBLToggle<cr>")
vim.keymap.set("n", "<leader>ts", "<cmd>set spell!<cr>")
vim.keymap.set("n", "<leader>tn", "<cmd>set relativenumber!<cr>")
vim.keymap.set("n", "<leader>tw", "<cmd>set wrap!<cr>")

vim.keymap.set("n", "<leader>r", "<cmd>LspRestart<cr>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")

-- --------------------------------------------------------------------------------------
-- PLUGIN LIST
-- --------------------------------------------------------------------------------------
local plugins = {
   {
      "TaDaa/vimade",
      event = "VeryLazy",
      opts = {
         fadelevel = 0.3,
         blocklist = {
            only_behind_float_windows = function(win, current)
               if
                  (win.win_config.relative == "")
                  and (current and current.win_config.relative ~= "")
               then
                  return false
               end
               return true
            end,
         },
      },
   },

   {
      "voldikss/vim-floaterm",
      config = function()
         vim.g.floaterm_opener = "edit"
         vim.g.floaterm_title = ""
         vim.g.floaterm_width = 0.6
         vim.g.floaterm_height = 0.99
      end,
      keys = {
         { "<leader>e", "<cmd>FloatermNew --height=0.92 vifm<cr>" },
         { "<leader>lg", "<cmd>FloatermNew --width=0.78 lazygit<cr>" },
      },
   },

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

   -- On first install run: Lazy build markdown-preview.nvim
   {
      "iamcco/markdown-preview.nvim",
      keys = {
         { "<leader>tm", "<cmd>MarkdownPreviewToggle<cr>" },
         { "<leader>lm", "<cmd>Lazy load markdown-preview.nvim<cr> | <cmd>Lazy<cr>" },
      },
   },

   {
      "brenoprata10/nvim-highlight-colors",
      ft = { "css", "html" },
      opts = {
         render = "virtual",
         virtual_symbol = "■■",
      },
   },

   { "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },

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
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      dependencies = {
         { "nvim-lua/plenary.nvim" },
         { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      },
      config = function()
         local actions = require("telescope.actions")

         require("telescope").setup({
            defaults = {
               layout_strategy = "vertical",
               layout_config = {
                  preview_cutoff = 0,
                  width = 0.6,
                  height = 0.9,
                  preview_height = 0.6,
               },
               file_ignore_patterns = { "node_modules" },
               borderchars = {
                  "─",
                  "│",
                  "─",
                  "│",
                  "┌",
                  "┐",
                  "┘",
                  "└",
               },
               mappings = { i = { ["<esc>"] = actions.close } },
            },
            pickers = {
               buffers = {
                  sort_lastused = true,
                  ignore_current_buffer = true,
               },
            },
            extensions = {
               fzf = {
                  fuzzy = true,
                  override_file_sorter = true,
                  case_mode = "smart_case",
                  override_generic_sorter = true,
               },
            },
         })

         require("telescope").load_extension("fzf")
      end,
      keys = {
         { "<leader>fi", "<cmd>Telescope find_files previewer=false<cr>" },
         { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
         { "<leader>fo", "<cmd>Telescope resume<cr>" },
         { "<leader>fj", "<cmd>Telescope buffers previewer=false<cr>" },
         { "<leader>fr", "<cmd>Telescope lsp_references<cr>" },

         {
            "<leader>fw",
            "<cmd>lua require('telescope.builtin').grep_string({ search=vim.fn.expand('<cword>') })<cr>",
         },
         {
            "<leader>fW",
            "<cmd>lua require('telescope.builtin').grep_string({ search=vim.fn.expand('<cWORD>') })<cr>",
         },

         { "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>" },
         { "<leader>fD", "<cmd>Telescope diagnostics<cr>" },
      },
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
                     title = " Harpoon ",
                     border = "single",
                     title_pos = "center",
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
               "rust",
               "c",
               "python",
               "lua",
               "vim",
               "vimdoc",
            },
            sync_install = false,
            indent = { enable = true },
            highlight = {
               enable = true,
               additional_vim_regex_highlighting = { "markdown" },
               disable = function(_, bufnr) -- Disable for files with +1K lines
                  return vim.api.nvim_buf_line_count(bufnr) > 1000
               end,
            },
         })
      end,
   },

   { "windwp/nvim-ts-autotag", event = "VeryLazy", opts = {} },
   { "windwp/nvim-autopairs", event = "VeryLazy", opts = {} },

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
      "stevearc/conform.nvim",
      event = "VeryLazy",
      config = function()
         require("conform").setup({
            formatters_by_ft = {
               javascript = { "prettier" },
               typescript = { "prettier" },
               javascriptreact = { "prettier" },
               typescriptreact = { "prettier" },
               css = { "prettier" },
               json = { "prettier" },
               markdown = { "prettier" },
               python = { "black" },
               lua = { "stylua" },
            },
            formatters = {
               prettier = {
                  prepend_args = {
                     "--print-width",
                     "90",
                  },
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
                     "100",
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

   {
      "neovim/nvim-lspconfig", -- Don't lazy load
      dependencies = {
         "williamboman/mason.nvim",
         "williamboman/mason-lspconfig.nvim",
      },
      config = function()
         local lspconfig = require("lspconfig")
         local cmp_lsp = require("cmp_nvim_lsp")
         local capabilities = cmp_lsp.default_capabilities()

         local lsp_attach = function(client, bufnr)
            local opts = { buffer = bufnr, silent = true }
            vim.keymap.set("n", "gh", ":silent lua vim.lsp.buf.hover()<cr>", opts)
            vim.keymap.set("n", "gd", ":silent lua vim.lsp.buf.definition()<cr>", opts)
            vim.keymap.set("n", "<leader>xx", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
            vim.keymap.set("n", "<leader>sr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            vim.keymap.set("n", "<leader>vj", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
            vim.keymap.set("n", "<leader>vk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
            vim.keymap.set("n", "<leader>vd", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
         end

         vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = false,
            float = { border = "single" },
         })

         local open_float = vim.lsp.util.open_floating_preview
         function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = "single"
            return open_float(contents, syntax, opts, ...)
         end

         -- [eslint-lsp] [prettier]
         -- [typescript-server]
         -- [css-lsp] [stylelint]
         -- [html-lsp] [json-lsp]
         -- [marksman] ## JavasCript

         -- [stylua] ## Lua
         -- [black] [pyright] ## Python

         require("mason").setup({
            ui = { border = "single" },
         })
         require("mason-lspconfig").setup({
            handlers = {
               function(server_name)
                  require("lspconfig")[server_name].setup({
                     capabilities = capabilities,
                     on_attach = lsp_attach,
                  })
               end,
            },
         })
      end,
   },

   {
      "L3MON4D3/LuaSnip",
      event = "VeryLazy",
      dependencies = {
         "rafamadriz/friendly-snippets",
         config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
         end,
      },
   },

   {
      "hrsh7th/nvim-cmp",
      event = "VeryLazy",
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "saadparwaiz1/cmp_luasnip",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-buffer",
      },
      opts = function()
         local cmp = require("cmp")
         require("luasnip").filetype_extend("javascriptreact", { "html" })

         cmp.setup({
            completion = { completeopt = "menu, menuone, noinsert" },
            sources = {
               { name = "path" },
               { name = "nvim_lsp" },
               { name = "luasnip" },
               { name = "buffer" },
            },
            snippet = {
               expand = function(args)
                  require("luasnip").lsp_expand(args.body)
               end,
            },
            view = { docs = { auto_open = false } },
            window = {
               documentation = { winhighlight = "Normal:MatchParen,FloatBorder:MatchParen" },
            },
            mapping = cmp.mapping.preset.insert({
               ["<Enter>"] = cmp.mapping.confirm({ select = true }),
               ["<C-Space>"] = cmp.mapping(function()
                  if cmp.visible_docs() then
                     cmp.close_docs()
                  else
                     cmp.open_docs()
                  end
               end),
            }),
         })
      end,
   },
}

-- --------------------------------------------------------------------------------------
-- PLUGIN INSTALLATION
-- --------------------------------------------------------------------------------------
local themes = require("themes") -- Load themes - GruvDark reference
vim.list_extend(plugins, themes) -- Merge themes to main plugin list

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

require("lazy").setup(plugins, {
   ui = { border = "single" },
   change_detection = { enabled = false, notify = false },
   performance = {
      cache = { enabled = true },
      rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } },
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
local yank = vim.highlight.on_yank
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
-- InsertMode cursor color
vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:block-Cursor2"

-- File changed sign in editor
vim.fn.sign_define("FileChanged", { text = "✗", texthl = "WarningMsg", numhl = "WarningMsg" })

local function update_sign()
   if vim.bo.filetype:match("^harpoon") then
      return
   end
   local buf, line = vim.api.nvim_get_current_buf(), vim.api.nvim_win_get_cursor(0)[1]

   if vim.bo.modified then
      vim.fn.sign_unplace("user", { buffer = buf })
      vim.fn.sign_place(0, "user", "FileChanged", buf, { lnum = line, priority = 1 })
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
