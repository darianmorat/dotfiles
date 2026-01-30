-- ======================================================================================
-- TITLE: Options
-- ======================================================================================

-- Global settings
vim.g.mapleader = " "
vim.g.markdown_recommended_style = 0

-- Basic settings
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 6
vim.opt.wrap = false

-- Spell settings
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"

-- Statusline settings
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.cmdheight = 0
vim.opt.laststatus = 0

-- Visual settings
vim.opt.termguicolors = true
vim.opt.pumheight = 10
vim.opt.guicursor = ""
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "90"

-- Indentation settings
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.tabstop = 3
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search settings
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- File handling settings
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true

-- Performance settings
vim.opt.updatetime = 100
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0

-- Behavior settings
vim.opt.fileencoding = "UTF-8"
vim.opt.mouse = "a"
vim.schedule(function()
   vim.opt.clipboard = "unnamedplus"
end)

-- ======================================================================================
-- TITLE: Keymaps
-- ======================================================================================

-- Handle gitsigns diff
local function smart_quit()
   if vim.wo.diff then
      vim.cmd("wincmd p | q")
   else
      vim.cmd(":q")
   end
end

-- File handling
vim.keymap.set("n", "<leader>q", smart_quit)
vim.keymap.set("n", "<leader>w", ":silent w<cr>", { silent = true })
vim.keymap.set("n", "<leader>d", "<cmd>bd<cr>")
vim.keymap.set("n", "<leader><leader>d", "<cmd>bd!<cr>")
vim.keymap.set("n", "<leader><leader>b", "<cmd>BufOnly<cr>")

-- Centered jumps
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Editing helpers
vim.keymap.set("n", "K", "mzi<cr><Esc>`z")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-k>", "<C-6>")

-- Registers
vim.keymap.set({ "n", "v" }, "<leader>y", '"ay')
vim.keymap.set({ "n", "v" }, "<leader>p", '"ap')
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d')

-- Toggles
vim.keymap.set("n", "<leader>ti", "<cmd>IBLToggle<cr>")
vim.keymap.set("n", "<leader>ts", "<cmd>set spell!<cr>")
vim.keymap.set("n", "<leader>tn", "<cmd>set relativenumber!<cr>")
vim.keymap.set("n", "<leader>tw", "<cmd>set wrap!<cr>")

-- Visual mode improvements
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { silent = true })

-- Floating helper
local function float_terminal(cmd)
   local buf = vim.api.nvim_create_buf(false, true)
   local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      row = 0,
      col = 0,
      width = vim.o.columns,
      height = vim.o.lines,
   })
   vim.fn.termopen(cmd, {
      on_exit = function()
         vim.api.nvim_win_close(win, true)
         vim.api.nvim_buf_delete(buf, { force = true })
      end,
   })
   vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>lg", function()
   float_terminal("lazygit")
end)

-- ======================================================================================
-- TITLE: Plugin list
-- ======================================================================================

local plugins = {
   {
      -- "darianmorat/gruvdark.nvim",
      dir = "~/dev/gruvdark.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
   },

   {
      "b0o/incline.nvim",
      event = "VeryLazy",
      config = function()
         require("incline").setup({
            render = function(props)
               local filename =
                  vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")

               if vim.bo[props.buf].filetype == "oil" or filename == "" then
                  return ""
               end

               local modified = vim.bo[props.buf].modified and " [+]" or ""

               return {
                  "▓▒ ",
                  filename,
                  modified,
                  " ▒▓",
               }
            end,
            hide = {
               cursorline = false,
            },
            window = {
               margin = {
                  horizontal = 0,
                  vertical = 0,
               },
               padding = 0,
               placement = {
                  horizontal = "right",
                  vertical = "top",
               },
            },
         })
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
            ["gs"] = { "actions.change_sort", mode = "n" },
            -- gx = open externally with selected app

            ["<C-i>"] = {
               callback = function()
                  require("fzf-lua").files({
                     cwd = require("oil").get_current_dir(),
                     fd_opts = "--color=never --type d --hidden --follow --exclude .git",
                     previewer = false,
                  })
               end,
               mode = "n",
            },

            ["<C-o>"] = {
               callback = function()
                  require("fzf-lua").files({
                     cwd = vim.fn.getcwd(),
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
               file_ignore_patterns = {
                  "node_modules",
                  "package%-lock%.json",
               },
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
         -- exclude = {
         --    filetypes = { "python" },
         -- },
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
                  padding = 1,
                  columns = {
                     { "label", "label_description", gap = 1 },
                     { "kind", gap = 1 },
                  },
               },
            },
            documentation = {
               auto_show = true,
               auto_show_delay_ms = 0,
               window = {
                  border = { "", "", "", " ", "", "", "", " " },
                  winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDoc",
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
         },
      },
      opts_extend = { "sources.default" },
   },

   {
      "neovim/nvim-lspconfig",

      -- npm install -g typescript-language-server -- # ts_ls
      -- npm install -g vscode-langservers-extracted -- # eslint, html, cssls, jsonls
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

         vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
               vim.lsp.document_color.enable(true, args.buf, {
                  style = "background",
               })
            end,
         })

         vim.lsp.config("*", {})
         vim.lsp.enable({
            "ts_ls",
            "eslint",
            "html",
            "cssls",
            "jsonls",
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

         vim.keymap.set("n", "<leader>fk", function()
            require("conform").format({
               lsp_fallback = true,
               async = false,
               timeout_ms = 1000,
            })
         end)
      end,
   },
}

-- ======================================================================================
-- TITLE: Plugin installation
-- ======================================================================================

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
   ui = {
      border = "none",
      size = { width = 1, height = 1 },
   },
   defaults = {
      lazy = false,
      version = false,
   },
   checker = {
      enabled = false,
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

-- ======================================================================================
-- TITLE: Commands & Auto-commands
-- ======================================================================================

-- Apply colorscheme
dofile(
   vim.fn.expand("~/.config/theme-manager/")
      .. (os.getenv("THEME_MODE") or "dark")
      .. "/nvim.lua"
)

-- Close all buffers except current
vim.api.nvim_create_user_command("BufOnly", function()
   local listed_buffers = 0
   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].buflisted then
         listed_buffers = listed_buffers + 1
      end
   end
   local closed_count = listed_buffers - 1
   vim.cmd([[silent! execute '%bd|e#|bd#']])
   vim.notify(closed_count .. " buffers closed")
end, {})

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

-- Fixes 'cmdheight=0' flickering on InsertMode
vim.api.nvim_create_autocmd("ModeChanged", {
   callback = function()
      if vim.fn.mode() == "i" then
         vim.schedule(vim.cmd.redraw)
      end
   end,
})

-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup("LastCursorGroup", {})
vim.api.nvim_create_autocmd("BufWinEnter", {
   group = last_cursor_group,
   callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
         pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
   end,
})

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

-- Automatically Split help Buffers to the right
vim.api.nvim_create_autocmd("BufWinEnter", {
   pattern = "*.txt",
   callback = function()
      if vim.bo.filetype == "help" then
         vim.cmd("wincmd L")
      end
   end,
})
