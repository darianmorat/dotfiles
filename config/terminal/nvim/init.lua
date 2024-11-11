-- -------------------------------------------------------------------------------------------
-- SETTINGS
-- -------------------------------------------------------------------------------------------
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

vim.opt.updatetime = 80
vim.opt.mouse = ""
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.opt.softtabstop = 3
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.spell = false
vim.opt.spelllang = "en_us"
vim.opt.spelloptions="camel"

vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 6
vim.opt.colorcolumn = "95"
vim.opt.signcolumn = "yes"
vim.opt.undofile = true

vim.opt.swapfile = false
vim.opt.backup = false
fileencoding = "utf-8"
vim.opt.showtabline = 0
vim.g.markdown_recommended_style = 0

vim.schedule(function()
   vim.opt.clipboard = "unnamedplus"
end)

-- -------------------------------------------------------------------------------------------
-- REMAPS
-- -------------------------------------------------------------------------------------------
local function smart_quit() -- Fix: quit in diff
   if vim.wo.diff then vim.cmd("wincmd p | q")
   else vim.cmd(":q") end
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
vim.keymap.set("n", "<leader>h", "<c-g>")

vim.keymap.set("n", "<leader>e", "<cmd>FloatermNew --height=0.88 vifm<cr>")
vim.keymap.set("n", "<leader>lg", "<cmd>FloatermNew --width=0.75 lazygit<cr>")

vim.keymap.set("n", "<leader>tI", "<cmd>IBLToggle<cr>")
vim.keymap.set("n", "<leader>ti", "m`<cmd>ToggleScope<CR>| <cmd>IBLToggle<cr>``")
vim.keymap.set("n", "<leader>ts", "<cmd>set spell!<cr>")
vim.keymap.set("n", "<leader>tn", "<cmd>set relativenumber!<cr>")
vim.keymap.set("n", "<leader>tw", "<cmd>set wrap!<cr>")
vim.keymap.set("n", "<leader>tu", "<cmd>UndotreeToggle<cr>| <cmd>UndotreeFocus<cr> ")

vim.keymap.set("n", "<leader>tm", "<cmd>MarkdownPreviewToggle<cr>")
vim.keymap.set("n", "<leader>lm", "<cmd>Lazy load markdown-preview.nvim<cr>| <cmd>Lazy<cr>")

vim.keymap.set("n", "<leader>r", "<cmd>LspRestart<cr>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")

-- -------------------------------------------------------------------------------------------
-- PLUGIN LIST
-- -------------------------------------------------------------------------------------------
local plugins = {
   { "TaDaa/vimade", event = "VeryLazy",
      opts = {
         fadelevel = 0.3,
         blocklist = {
            only_behind_float_windows = function(win, current)
               if (win.win_config.relative == "") and 
                  (current and current.win_config.relative ~= "") then
                  return false 
               end
               return true
            end
         }
      }
   },

   { "voldikss/vim-floaterm", cmd = "FloatermNew",
      config = function() 
         vim.g.floaterm_title = ""
         vim.g.floaterm_width = 0.6
         vim.g.floaterm_height = 0.99
         vim.g.floaterm_opener = "edit"
      end
   },

   { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
   { "numToStr/Comment.nvim", event = "VeryLazy",
      config = function()
         require("Comment").setup({
            pre_hook = require(
               "ts_context_commentstring.integrations.comment_nvim"
            ).create_pre_hook()
         })
         vim.keymap.set("n", "<leader>cc", "gcc", { remap = true })
         vim.keymap.set("n", "<leader>cb", "gbc", { remap = true })
         vim.keymap.set("n", "<leader>ca", "gcA", { remap = true })
         vim.keymap.set("n", "<leader>co", "gco", { remap = true })
         vim.keymap.set("n", "<leader>cO", "gcO", { remap = true })

         vim.keymap.set("v", "<leader>c", "gc", { remap = true })
         vim.keymap.set("v", "<leader>b", "gb", { remap = true })
      end
   },

   -- On first install run: Lazy build markdown-preview.nvim
   { "iamcco/markdown-preview.nvim", cmd = { "MarkdownPreviewToggle" } },
   { "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },

   { "jake-stewart/multicursor.nvim", branch = "1.0", event = "VeryLazy",
      config = function()
         local mc = require("multicursor-nvim")
         mc.setup({})

         vim.keymap.set({"n", "v"}, "<c-l>", mc.matchAllAddCursors)
         vim.keymap.set({"n"}, "<c-n>", "viw")
         vim.keymap.set({"v"}, "<c-n>", "")
         vim.keymap.set({"v"}, "n", function() mc.matchAddCursor(1) end)
         vim.keymap.set({"v"}, "N", function() mc.matchAddCursor(-1) end)
         vim.keymap.set({"v"}, "u", mc.deleteCursor)

         vim.keymap.set("n", "<esc>", function()
            if not mc.cursorsEnabled() then mc.enableCursors()
            elseif mc.hasCursors() then mc.clearCursors() 
            else --[[ <esc> ]] end
         end)
      end
   },

   { "mbbill/undotree", cmd = "UndotreeToggle",
      config = function()
         vim.g.undotree_WindowLayout = 3
         vim.g.undotree_SplitWidth = 38
         vim.g.undotree_ShortIndicators = 0
         vim.g.undotree_DiffAutoOpen = 0
      end
   },

   { "folke/flash.nvim",
      opts = {
         highlight = { backdrop = true },
         prompt = { enabled = false },
         modes = { char = { enabled = false } }
      },
      keys = {
         { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end },
         { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end }
      }
   },

   { "nvim-telescope/telescope.nvim", tag = "0.1.8",
      dependencies = {
         { "nvim-lua/plenary.nvim" },
         { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
      },
      keys = {
         { "<leader>ff", "<cmd>Telescope find_files previewer=false<cr>"},
         { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
         { "<leader>fo", "<cmd>Telescope resume<cr>" },
         { "<leader>fj", "<cmd>Telescope buffers previewer=false<cr>" },
         { "<leader>fr", "<cmd>Telescope lsp_references<cr>" },

         { "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string({ search=vim.fn.expand('<cword>') })<cr>" },
         { "<leader>fW", "<cmd>lua require('telescope.builtin').grep_string({ search=vim.fn.expand('<cWORD>') })<cr>" },

         { "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>" },
         { "<leader>fD", "<cmd>Telescope diagnostics<cr>" },
      },
      config = function ()
      local actions = require("telescope.actions")

      require("telescope").setup({
         defaults = {
            layout_strategy = "vertical",
            layout_config = {
               preview_cutoff = 0,
               width = 0.6,
               height = 35,
               preview_height = 0.6
            },
            file_ignore_patterns = { "node_modules" },
            borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            mappings = { i = { [ "<esc>" ] = actions.close } }
         },
         pickers = {
            buffers = {
               sort_lastused = true,
               ignore_current_buffer = true
            }
         },
         extensions = {
            fzf = {
               fuzzy = true,
               override_generic_sorter = true,
               override_file_sorter = true,
               case_mode = "smart_case"
            }
         }
      })

      require("telescope").load_extension("fzf")
      end
   },

   { "ThePrimeagen/harpoon", branch = "harpoon2",
      dependencies = { { "nvim-lua/plenary.nvim" } },
      opts = {
         settings = {
            save_on_toggle = true,
            sync_on_ui_close = true
         }
      },
      keys = function()
         local is_first_run = true -- Fix: Doesn't close [No Name] buffer as Telescope
         local function handler()
            if is_first_run then vim.cmd("bd 1") is_first_run = false end
         end

         local keys = {
            { "<c-m>", function() require("harpoon"):list():add() end },
            { "<tab>", function() require("harpoon"):list():prev() handler() end },
            { "<c-o>", function() require("harpoon"):list():next() handler() end },

            { "<leader>1", function() require("harpoon"):list():select(1) handler() end },
            { "<leader>2", function() require("harpoon"):list():select(2) handler() end },
            { "<leader>3", function() require("harpoon"):list():select(3) handler() end },
            { "<leader>4", function() require("harpoon"):list():select(4) handler() end },

            { "<leader>fk", function()
               local harpoon = require("harpoon")
               local UI = { 
                  title = " Harpoon ",
                  border = "single", 
                  title_pos = "center", 
                  ui_width_ratio = 0.6 
               }
               harpoon.ui:toggle_quick_menu(harpoon:list(), UI)
               end
            }
         }
         return keys
      end
   },

   { "lewis6991/gitsigns.nvim", event = "BufReadPre",
      config = function()
         require("gitsigns").setup({
            on_attach = function(bufnr)
               local gs = require("gitsigns")
               local ln = vim.fn.line

               local function map(mode, l, r, opts)
                  opts = opts or {}
                  opts.buffer = bufnr
                  vim.keymap.set(mode, l, r, opts)
               end

               map("n", "<leader>gi", gs.diffthis)
               map("n", "<leader>gI", function() gs.diffthis("~") end)

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
      end
   },

   { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = "BufReadPre",
      config = function()
         require"nvim-treesitter.configs".setup({
            ensure_installed = {
               "lua", "javascript", "typescript", "tsx", --[[ "html", "css", ]]
               "json", "jsonc", "diff", "markdown", "markdown_inline", --[[ "yaml", ]]
            },
            sync_install = false,
            indent = { enable = true },
            highlight = {
               enable = true,
               additional_vim_regex_highlighting = { "markdown" },
               disable = function(_, bufnr) -- Disable for files with +1K lines
                  return vim.api.nvim_buf_line_count(bufnr) > 1000
               end
            }
         })
      end
   },

   { "windwp/nvim-ts-autotag", event = "VeryLazy", opts = {} },
   { "windwp/nvim-autopairs", event = "VeryLazy", opts = {} },

   { "lukas-reineke/indent-blankline.nvim", main = "ibl", lazy = true,
      opts = {
         indent = {
            char = "╎", -- │╎|
            tab_char = "╎"
         },
         scope = {
            enabled = false,
            show_start = false,
            show_end = false
         }
      }
   },

   { "echasnovski/mini.indentscope", version = "*", event = "BufReadPre",
      opts = {
         symbol = "╎", -- │╎|
         draw = {
            delay = 0,
            animation = function()
               return 0
            end
         }
      }
   },

   { "neovim/nvim-lspconfig", -- Don't lazy load
      dependencies = {
         "williamboman/mason.nvim",
         "williamboman/mason-lspconfig.nvim"
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

         vim.diagnostic.config({ virtual_text = false })
         vim.diagnostic.config { float = { border = "single" } }

         vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover, { border = "single" }
         )

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
      end
   },

   { "L3MON4D3/LuaSnip", event = "VeryLazy",
      dependencies = {
         "rafamadriz/friendly-snippets",
         config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
         end
      }
   }, 

   { "hrsh7th/nvim-cmp", event = "VeryLazy",
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "saadparwaiz1/cmp_luasnip",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-buffer"
      },
      opts = function()
         local cmp = require("cmp")
         require("luasnip").filetype_extend("javascriptreact", { "html" })

         cmp.setup({
            completion = {
               completeopt = "menu, menuone, noinsert"
            },
            sources = { 
               { name = "nvim_lsp" },
               { name = "luasnip" },
               { name = "path" },
               { name = "buffer" }
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
               ["<F13>"] = cmp.mapping(function() -- C-Space x2, WezTerm binding
                  if cmp.visible_docs() then cmp.close_docs()
                  else cmp.open_docs() end
               end)
            })
         })
      end
   }
}

-- -------------------------------------------------------------------------------------------
-- PLUGIN INSTALLATION
-- -------------------------------------------------------------------------------------------
local themes = require("themes") -- Load themes - GruvDark reference
vim.list_extend(plugins,themes) -- Merge themes to main plugin list

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
   ui = { border = "single" },
   change_detection = {
      enabled = false,
      notify = false
   },
   performance = {
      cache = { enabled = true },
      rtp = {
         disabled_plugins = {
            "gzip",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin"
         }
      }
   }
})

-- -------------------------------------------------------------------------------------------
-- COMMANDS
-- -------------------------------------------------------------------------------------------
vim.cmd.colorscheme("onedark") -- Default colorscheme
vim.cmd("command BufOnly silent! execute '%bd|e#|bd#'") -- Close all others buffers
vim.cmd("autocmd BufNewFile,BufRead * setlocal formatoptions-=cro") -- No auto-comments

-- Yank highlighting
vim.cmd("highlight YankHighlight guibg=#2b2b2b guifg=#e6e3de")
local yank = vim.highlight.on_yank
vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", { group = "YankHighlight",
   callback = function() yank({ higroup = "YankHighlight", timeout = 190 }) end
})

-- Fixes 'cmdheight=0' flickering when using InsertMode
vim.api.nvim_create_autocmd("ModeChanged", {
  callback = function()
    if vim.fn.mode() == "i" then vim.schedule(vim.cmd.redraw) end
  end
})

-- Toggle Scope Indentation
vim.cmd("command! ToggleScope lua ToggleScope()")
function ToggleScope()
   vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
end

-- Disable Line Indentation
require("ibl").overwrite {
   exclude = { filetypes = { "help", "undotree" } }
}

-- Disable Scope Indentation
vim.api.nvim_create_autocmd({ "FileType" }, {
   callback = function()
      local ignore_filetypes = { "help", "undotree", "lazy", "mason", "startuptime" }
      if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
         vim.b.miniindentscope_disable = true
      end
   end
})

-- -------------------------------------------------------------------------------------------
-- INDICATORS
-- -------------------------------------------------------------------------------------------
-- InsertMode indicator: Relies in WezTerm force_reverse_video_cursor
vim.opt.guicursor="n-v-c:block-Cursor,i-ci-ve:block-Cursor2"

-- File changed indicator
local last_line = -1

vim.fn.sign_define("FileChanged", { 
   text = "x", 
   texthl = "WarningMsg", 
   numhl = "WarningMsg" 
})

vim.api.nvim_create_autocmd({"TextChangedI", "TextChanged", "BufWritePost", "CursorMoved"}, {
   callback = function() 
      if vim.bo.filetype:match("^harpoon") then 
         return -- Ignore harpoon buffer
      end

      local current_line = vim.api.nvim_win_get_cursor(0)[1]
      local current_buf = vim.api.nvim_get_current_buf()

      if not vim.bo.modified then
      vim.fn.sign_unplace("user", { buffer = current_buf })
         return -- If buffer is not modified, remove the sign and return early
      end
      if current_line == last_line then
         return -- If the line has not changed, don't update the sign
      end

      last_line = current_line -- Update last_line and place new sign on current line

      -- Unplace any existing sign and place a new one at the current line
      vim.fn.sign_unplace("user", { buffer = current_buf })
      vim.fn.sign_place(0, "user", "FileChanged", current_buf, { 
         lnum = current_line, priority = 1  -- Place sign behind (use -1 to place in top)
      })
   end
})
