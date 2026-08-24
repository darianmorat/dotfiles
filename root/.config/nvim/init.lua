-- ================================================================================================
-- TITLE: Options
-- ================================================================================================

vim.loader.enable()

vim.g.mapleader = " "
vim.o.winborder = "single"
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.wrap = false

vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 6

vim.opt.guicursor = ""
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"

vim.opt.pumheight = 10
vim.opt.cmdwinheight = 10

vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.tabstop = 3
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.cmdheight = 0
vim.opt.laststatus = 0

vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true

vim.opt.updatetime = 100
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0

vim.o.title = true
vim.o.titleold = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
vim.o.titlestring = table.concat({
   "%{fnamemodify(getcwd(), ':t')} - ",
   "%{fnamemodify(expand('%'),':h')==?'.'?'':fnamemodify(expand('%'),':h:t').'/'}%t %m",
})

vim.schedule(function() vim.opt.clipboard = "unnamedplus" end)

-- ================================================================================================
-- TITLE: Keymaps
-- ================================================================================================

vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")
vim.keymap.set("n", "<leader>w", ":silent! w<cr>", { silent = true })

vim.keymap.set("n", "<leader>d", "<cmd>bd<cr>")
vim.keymap.set("n", "<leader>D", "<cmd>bd!<cr>")
vim.keymap.set("n", "<leader>B", "<cmd>BufOnly<cr>")

vim.keymap.set("n", "<c-k>", "<c-6>")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

vim.keymap.set({ "n", "v" }, "<leader>y", '"ay')
vim.keymap.set({ "n", "v" }, "<leader>p", '"ap')
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d')

vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { silent = true })

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

local copy_keymap = function(mode, cur_lhs, new_lhs)
   local map_data = vim.fn.maparg(cur_lhs, mode, false, true)
   map_data.lhs, map_data.lhsraw = new_lhs, vim.keycode(new_lhs)
   vim.fn.mapset(map_data)
end

copy_keymap("n", "gc", "<leader>c")
copy_keymap("x", "gc", "<leader>c")
copy_keymap("o", "gc", "<leader>c")
copy_keymap("n", "gcc", "<leader>cc")

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

local terminals = {}

local function float_opts()
   return {
      relative = "editor",
      row = 0,
      col = 0,
      width = vim.o.columns,
      height = vim.o.lines,
      border = "none",
   }
end

local function float(cmd)
   local t = terminals[cmd]
   if t and vim.api.nvim_buf_is_valid(t) then
      vim.api.nvim_open_win(t, true, float_opts())
      vim.cmd.startinsert()
      return
   end

   local buf = vim.api.nvim_create_buf(false, true)
   vim.bo[buf].bufhidden = "hide"
   vim.api.nvim_open_win(buf, true, float_opts())

   vim.fn.termopen(cmd, {
      on_exit = function()
         if vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
         end
         terminals[cmd] = nil
      end,
   })

   terminals[cmd] = buf
   vim.cmd.startinsert()
   vim.keymap.set("t", "q", function() vim.api.nvim_win_close(0, true) end, { buffer = buf })
end

vim.keymap.set("n", "<leader>lg", function() float("lazygit") end)

-- ================================================================================================
-- TITLE: Plugin hooks
-- ================================================================================================

vim.api.nvim_create_autocmd("PackChanged", {
   callback = function(ev)
      local name, kind = ev.data.spec.name, ev.data.kind
      if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
         if not ev.data.active then
            vim.cmd.packadd("nvim-treesitter")
         end
         vim.cmd("TSUpdate")
      end
   end,
})

-- ================================================================================================
-- TITLE: Plugin list
-- ================================================================================================

vim.pack.add({
   { src = "https://github.com/darianmorat/gruvdark.nvim" },
   { src = "https://github.com/stevearc/oil.nvim" },
   { src = "https://github.com/windwp/nvim-autopairs" },
   { src = "https://github.com/windwp/nvim-ts-autotag" },
   { src = "https://github.com/nvim-mini/mini.surround" },
   { src = "https://github.com/jake-stewart/multicursor.nvim" },
   { src = "https://github.com/mbbill/undotree" },
   { src = "https://github.com/folke/flash.nvim" },
   { src = "https://github.com/ibhagwan/fzf-lua" },
   { src = "https://github.com/lewis6991/gitsigns.nvim" },
   { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
   { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
   { src = "https://github.com/saghen/blink.lib" },
   { src = "https://github.com/saghen/blink.cmp" },
   { src = "https://github.com/neovim/nvim-lspconfig" },
   { src = "https://github.com/stevearc/conform.nvim" },
})

-- ================================================================================================
-- TITLE: Extra Install
-- ================================================================================================

-- treesitter (parser compiler):
-- sudo pacman -S tree-sitter-cli

-- conform.nvim (formatters):
-- sudo pacman -S prettier stylua python-black
-- sudo npm install -g @fsouza/prettierd

-- nvim-lspconfig (language servers):
-- sudo npm install -g @vtsls/language-server
-- sudo pacman -S pyright
-- sudo pacman -S \
-- vscode-html-languageserver \
-- vscode-css-languageserver \
-- vscode-json-languageserver \
-- eslint-language-server

-- ================================================================================================
-- TITLE: Local/UI config
-- ================================================================================================

-- vim.opt.runtimepath:prepend(vim.fn.expand("~/projects/gruvdark.nvim"))
-- vim.keymap.set("n", "<leader>r", "<cmd>ReloadTheme<cr>")

-- ================================================================================================
-- TITLE: Plugin config
-- ================================================================================================

local theme_file = io.open(os.getenv("HOME") .. "/.config/current_theme", "r")
local theme_mode = theme_file and theme_file:read("*l") or "dark"

if theme_file then
   theme_file:close()
end

local colorscheme = theme_mode == "light" and "gruvdark-light" or "gruvdark"

vim.o.background = theme_mode
vim.cmd.colorscheme(colorscheme)

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

require("oil").setup({
   default_file_explorer = true,
   delete_to_trash = true,
   use_default_keymaps = false,
   keymaps = {
      ["<bs>"] = { "actions.parent", mode = "n" },
      ["<cr>"] = "actions.select",
      ["<c-p>"] = "actions.preview",
      ["_"] = { "actions.open_cwd", mode = "n" },
      ["`"] = { "actions.cd", mode = "n" },
      ["q"] = { "actions.close", mode = "n" },
      ["g."] = { "actions.toggle_hidden", mode = "n" },
      ["gt"] = { "actions.toggle_trash", mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },
   },
   view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _) return name == ".." end,
   },
})

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>")

local function set_oil_hl_links()
   vim.api.nvim_set_hl(0, "OilDirHidden", { link = "OilDir" })
   vim.api.nvim_set_hl(0, "OilFileHidden", { link = "OilFile" })
end
set_oil_hl_links()

vim.api.nvim_create_autocmd("ColorScheme", { callback = set_oil_hl_links })
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

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

require("nvim-autopairs").setup({})
require("nvim-ts-autotag").setup({})
require("mini.surround").setup({})

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

local mc = require("multicursor-nvim")
mc.setup({})

vim.keymap.set({ "n", "v" }, "<c-up>", function() mc.lineAddCursor(-1) end)
vim.keymap.set({ "n", "v" }, "<c-down>", function() mc.lineAddCursor(1) end)

vim.keymap.set({ "n", "v" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
vim.keymap.set({ "n", "v" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

vim.keymap.set({ "v" }, "n", function() mc.matchAddCursor(1) end)
vim.keymap.set({ "v" }, "<leader>n", function() mc.matchSkipCursor(1) end)

vim.keymap.set({ "v" }, "N", function() mc.matchAddCursor(-1) end)
vim.keymap.set({ "v" }, "<leader>N", function() mc.matchSkipCursor(-1) end)

vim.keymap.set({ "v" }, "u", mc.deleteCursor)
vim.keymap.set({ "n", "v" }, "<c-l>", mc.matchAllAddCursors)

vim.keymap.set("n", "<esc>", function()
   if not mc.cursorsEnabled() then
      mc.enableCursors()
   else
      mc.clearCursors()
   end
end)

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

vim.g.undotree_WindowLayout = 3
vim.g.undotree_SplitWidth = 38
vim.g.undotree_SetFocusWhenToggle = 1

vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>")

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

require("flash").setup({
   prompt = { enabled = false },
})

vim.keymap.set({ "n", "x", "o" }, "f", function() require("flash").jump() end)
vim.keymap.set({ "n", "x", "o" }, "t", function() require("flash").treesitter() end)

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

require("fzf-lua").setup({
   defaults = {
      formatter = "path.filename_first",
      fzf_opts = {
         ["--no-multi"] = true,
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
            ["png"] = { "chafa" },
            ["jpg"] = { "chafa" },
            ["jpeg"] = { "chafa" },
            ["gif"] = { "chafa" },
         },
      },
   },
})

local function fzf_vertical(command)
   return function()
      require("fzf-lua")[command]({
         winopts = {
            preview = { layout = "vertical" },
         },
      })
   end
end

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

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

require("gitsigns").setup({
   signs = {
      add = { text = "❘" },
      change = { text = "❘" },
      delete = { text = "_" },
   },
   signs_staged = {
      add = { text = "❘" },
      change = { text = "❘" },
      delete = { text = "_" },
   },

   on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      local line = vim.fn.line

      local function map(mode, l, r, opts)
         opts = opts or {}
         opts.buffer = bufnr
         vim.keymap.set(mode, l, r, opts)
      end

      map("n", "<leader>gi", function()
         gitsigns.diffthis()
         vim.cmd("wincmd h")
      end)

      if vim.wo.diff then
         map("n", "q", function() vim.cmd("q") end)
      end

      map("n", "<leader>gj", gitsigns.next_hunk)
      map("n", "<leader>gk", gitsigns.prev_hunk)
      map("n", "<leader>go", gitsigns.preview_hunk)

      map("n", "<leader>gs", gitsigns.stage_hunk)
      map("v", "<leader>gs", function() gitsigns.stage_hunk({ line("."), line("v") }) end)
      map("n", "<leader>gr", gitsigns.reset_hunk)
      map("v", "<leader>gr", function() gitsigns.reset_hunk({ line("."), line("v") }) end)
      map("n", "<leader>gu", gitsigns.undo_stage_hunk)

      map("n", "<leader>gb", gitsigns.toggle_current_line_blame)
      map("n", "<leader>gB", function() gitsigns.blame_line({ full = true }) end)
      map("n", "<leader>gd", gitsigns.toggle_deleted)
   end,
})

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

local nts = require("nvim-treesitter")
nts.install({
   "javascript",
   "typescript",
   "tsx",
   "html",
   "css",
   "lua",
   "python",
   "json",
   "yaml",
   "bash",
   "markdown",
   "markdown_inline",
   "diff",
   "sql",
   "query",
   "regex",
})

vim.api.nvim_create_autocmd("FileType", {
   callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match)
      if lang and vim.treesitter.language.add(lang) then
         if vim.api.nvim_buf_line_count(args.buf) <= 10000 then
            vim.treesitter.start()
         end
      end
   end,
})

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

require("ibl").setup({
   indent = {
      char = "╎",
      tab_char = "╎",
   },
   scope = {
      enabled = false,
      show_start = false,
      show_end = false,
   },
})

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

require("blink.cmp").setup({
   fuzzy = {
      implementation = "lua",
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
   },
   cmdline = {
      enabled = false,
   },
   keymap = {
      preset = "enter",
   },
})

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

vim.diagnostic.config({
   virtual_text = false,
   underline = true,
   update_in_insert = false,
   status = { format = function(_) return "" end },
   jump = {
      on_jump = function(diagnostic, bufnr)
         if not diagnostic then
            return
         end
         vim.diagnostic.open_float({
            bufnr = bufnr,
            scope = "cursor",
            focus = false,
         })
      end,
   },
})

vim.lsp.config("*", {})
vim.lsp.enable({
   "vtsls",
   "eslint",
   "html",
   "cssls",
   "jsonls",
   "pyright",
})

vim.keymap.set("n", "<leader>vo", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>vj", function() vim.diagnostic.jump({ count = 1 }) end)
vim.keymap.set("n", "<leader>vk", function() vim.diagnostic.jump({ count = -1 }) end)

vim.keymap.set("n", "<leader>vi", function()
   local new_config = not vim.diagnostic.config().virtual_text
   vim.diagnostic.config({ virtual_text = new_config })
end)

-- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- -- -- --- --

local prettier = {
   "prettierd",
   "prettier",
   stop_after_first = true,
}

require("conform").setup({
   formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = prettier,
      javascriptreact = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      html = prettier,
      css = prettier,
      json = prettier,
      markdown = prettier,
   },
   format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 1000,
   },
})

-- ================================================================================================
-- TITLE: Commands & Auto-commands
-- ================================================================================================

vim.filetype.add({
   extension = { xaml = "xml" },
})

vim.api.nvim_set_hl(0, "SnippetTabstop", {})
vim.api.nvim_set_hl(0, "SnippetTabstopActive", {})

vim.keymap.set({ "i", "s" }, "<Esc>", function()
   if vim.snippet then
      vim.snippet.stop()
   end
   return "<Esc>"
end, { expr = true })

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

vim.api.nvim_create_autocmd("FileType", {
   callback = function() vim.opt_local.formatoptions:remove("o") end,
})

local hl_op = vim.hl.hl_op or vim.hl.on_yank
vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
   group = "YankHighlight",
   callback = function() hl_op({ higroup = "YankHighlight", timeout = 150 }) end,
})

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

vim.api.nvim_create_autocmd("RecordingEnter", {
   callback = function() print("Recording @" .. vim.fn.reg_recording()) end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
   callback = function() print("Stopped recording") end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
   pattern = "*.txt",
   callback = function()
      if vim.bo.filetype == "help" then
         vim.cmd("wincmd L")
      end
   end,
})

vim.api.nvim_create_user_command("ReloadTheme", function()
   for name, _ in pairs(package.loaded) do
      if name:match("^gruvdark") then
         package.loaded[name] = nil
      end
   end
   vim.cmd("runtime! colors/" .. colorscheme .. ".lua")
   vim.cmd.colorscheme(colorscheme)
end, {})

vim.api.nvim_create_autocmd("CmdwinEnter", {
   callback = function() vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = true }) end,
})

vim.api.nvim_create_autocmd("FileType", {
   pattern = { "nvim-pack", "help" },
   callback = function() vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = true }) end,
})
