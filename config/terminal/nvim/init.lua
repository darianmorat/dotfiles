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
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")

-- --------------------------------------------------------------------------------------
-- PLUGIN LIST
-- --------------------------------------------------------------------------------------
local plugins = {
   {
      "stevearc/oil.nvim",
      event = "VeryLazy",
      opts = {
         default_file_explorer = true,
         keymaps = {
            ["<BS>"] = { "actions.parent", mode = "n" },
            ["<CR>"] = "actions.select",
            ["_"] = { "actions.open_cwd", mode = "n" },
            ["q"] = { "actions.close", mode = "n" },
            ["g."] = { "actions.toggle_hidden", mode = "n" },

            ["<C-s>"] = { "actions.select", opts = { vertical = true } },
            ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
            ["<C-l>"] = "actions.refresh",
            ["g?"] = { "actions.show_help", mode = "n" },
            ["gs"] = { "actions.change_sort", mode = "n" },
            ["`"] = { "actions.cd", mode = "n" },
            ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
            ["g\\"] = { "actions.toggle_trash", mode = "n" },
            ["gx"] = "actions.open_external",

            ["<C-p>"] = {
               callback = function()
                  local oil = require("oil")
                  oil.open_preview({ vertical = true, split = "botright" })
               end,
            },

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
         },
         use_default_keymaps = false,
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
            cmd = "vifm",
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
            fzf_colors = {
               ["gutter"] = "-1",
               ["hl"] = "2",
               ["hl+"] = "2",
               ["info"] = "8",
               ["prompt"] = "4",
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

      -- npm install -g typescript-language-server
      -- npm install -g vscode-langservers-extracted  # html, css, json
      -- npm install -g @tailwindcss/language-server
      -- pip install pyright

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
            "html",
            "cssls",
            "tailwindcss",
            "jsonls",
            "pyright",
         })

         vim.keymap.set("n", "gh", vim.lsp.buf.hover)
         vim.keymap.set("n", "gd", vim.lsp.buf.definition)
         vim.keymap.set("n", "<leader>xx", vim.lsp.buf.code_action)
         vim.keymap.set("n", "<leader>sr", vim.lsp.buf.rename)
         vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)

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
   change_detection = {
      enabled = false,
      notify = false,
   },
   performance = {
      cache = { enabled = true },
      rtp = {
         disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
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
-- InsertMode cursor color
vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:block-Cursor2"

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
