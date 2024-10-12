" Settings
syntax on
let mapleader = ' '
set noshowmode
set noshowcmd
set guicursor=a:block
set relativenumber
set number
set tabstop=3
set shiftwidth=3
set expandtab
set clipboard=unnamedplus
set clipboard+=unnamedplus
set scrolloff=6
set colorcolumn=95
set nowrap
set signcolumn=yes
set updatetime=200
set nohlsearch
set ignorecase
set smartcase
set pumheight=8

" Plugins
call plug#begin()
Plug 'navarasu/onedark.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'folke/zen-mode.nvim',
Plug 'numToStr/Comment.nvim'
Plug 'kylechui/nvim-surround', { 'tag': '*' }
Plug 'jake-stewart/multicursor.nvim'

Plug 'ggandor/leap.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-lua/plenary.nvim'
Plug 'voldikss/vim-floaterm'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v4.x'}
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'L3MON4D3/LuaSnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
call plug#end()

" Remaps
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzz
nnoremap N Nzz

nnoremap K m`i<CR><Esc>``
nnoremap J m`J``

nnoremap <leader>a A
nnoremap <leader>i I
nnoremap <leader>z :ZenMode<CR>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader><leader>d :bd!<CR>
nnoremap <leader><leader>b :BufOnly<CR>
nnoremap <leader><leader>q :q<CR>

nnoremap <c-k> :FloatermNew lazygit<CR>
nnoremap <C-j> :FloatermNew vifm<CR>
nnoremap <C-h> <C-6>

vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '<+1<CR>gv=gv


" Pending for GruvDark theme
" ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇
lua << EOF
require('onedark').setup {
   style = 'warmer',
   code_style = {
      comments = 'none'
   },
   colors = {
      fg = '#CDC5B8',
      blue = '#5b98c9',
      red = '#DB6A6A',
      yellow = '#D19F66',
      green = '#76B568',
      cyan = '#CDC5B8',
      purple = '#CD60B9',
      aqua = '#4DB0BD',
      orange = '#D19F66',
   },
   highlights ={
   Normal = { bg= '#1E1E1E' },
   CursorLine = { bg = '#303030' },
   Visual = { bg = '#353535' },
   TelescopeSelection = { bg = '#303030'},
   ['@operator'] = { fg = '$blue' },
   ['@punctuation'] = { fg = '$fg' },
   ['@punctuation.bracket'] = { fg = '$fg' },
   ['@variable'] = {fg = '$fg'},
   ['@variable.member'] = {fg = '$fg'},
   ['@variable.parameter'] = {fg = '$fg'},
   ['@lsp.type.typeParameter'] = {fg = '$fg'},
   ['@lsp.type.parameter'] = {fg = '$fg'},
   ['@function'] = {fg = '$red'},
   ['@function.method'] = {fg = '$red'},
   ['@constructor'] = {fg = '$blue'},
   ['@keyword'] = {fg = '$blue'},
   ['@variable.builtin'] = {fg = '$yellow'},
   ['@type'] = {fg = '$aqua'},
   ['@type.builtin'] = {fg = '$aqua'},
   ['@tag'] = {fg = '$red'},
   ['@tag.delimiter'] = {fg = '$red'},
   ['@tag.attribute'] = {fg = '#9266DA'},
   ["@markup.heading"] = {fg = '$fg', fmt = 'none'},

   ["@property.css"] = { fg = '$blue' },  
   ["@string.css"] = { fg = '$yellow' },  
   ["@tag.css"] = { fg = '$red' },  
   ["@type.css"] = { fg = '$red' },  
   ["@operator.css"] = { fg = '$red' },  
   ["@attribute.css"] = { fg = '$red' },  

   TSParameter = { fg = '$fg' },
   TSParameterReference = { fg = '$fg' },
   }
}
EOF
colorscheme onedark
highlight Comment gui=NONE 
highlight SignColumn ctermbg=NONE guibg=NONE
highlight EndOfBuffer guibg=NONE ctermbg=NONE
highlight ColorColumn ctermbg=237 guibg=#222222
" ⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆
" Pending for GruvDark theme


" Extra
" Remove all active buffers except current and unsaved
command BufOnly silent! execute '%bd|e#|bd#' 
" No auto-comment using motions
autocmd BufEnter * set formatoptions-=cro 
autocmd BufEnter * setlocal formatoptions-=cro
" Clear cmd line - uses 'updatetime'
autocmd CursorHold * echon ''
autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup='YankHighlight', timeout=190}
highlight YankHighlight guibg=#2b2b2b guifg=#e6e3de
highlight incsearch guibg=#5c5c5e guifg=#e6e3de

" Floaterm 
let g:floaterm_title = ''
let g:floaterm_height = 0.95
let g:floaterm_width = 0.6
let g:floaterm_position = 'top'
let g:floaterm_opener = 'edit'
hi FloatermBorder guibg=#1e1e1e guifg=NONE

" Leap 
lua << EOF
require('leap')
vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = '#e6e3de', bg = '#5c5c5e' })
EOF

" Comment 
lua << EOF
require('Comment').setup()
vim.keymap.set('n', '<leader>cc', 'gcc', { remap = true })
vim.keymap.set('n', '<leader>cb', 'gbc', { remap = true })
vim.keymap.set('n', '<leader>ca', 'gcA', { remap = true })
vim.keymap.set('n', '<leader>co', 'gco', { remap = true })
vim.keymap.set('n', '<leader>cO', 'gcO', { remap = true })

vim.keymap.set('v', '<leader>c', 'gc', { remap = true })
vim.keymap.set('v', '<leader>b', 'gb', { remap = true })
EOF

" Surround
lua << EOF
require('nvim-surround').setup()
EOF

" Multicursor 
lua << EOF
local mc = require('multicursor-nvim')
local set = vim.keymap.set
mc.setup()

set({'n', 'v'}, "<c-l>", mc.matchAllAddCursors)
set({'n'}, '<c-n>', 'viw')
set({'v'}, '<c-n>', '')
set({'v'}, 'n', function() mc.matchAddCursor(1) end)
set({'v'}, 'N', function() mc.matchAddCursor(-1) end)
set({"v"}, "u", mc.deleteCursor)

set('n', '<esc>', function()
   if not mc.cursorsEnabled() then
      mc.enableCursors()
   elseif mc.hasCursors() then
      mc.clearCursors()
   else
   end
end)
EOF

" Telescope 
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({ previewer = false })<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').resume()<cr>
nnoremap <leader>fj <cmd>lua require('telescope.builtin').buffers({ previewer = false, sort_lastused = true})<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>fw <cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>
nnoremap <leader>fW <cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cWORD>') })<CR>
nnoremap <leader>ej <cmd>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>

lua << EOF
require('telescope').setup {
   defaults = {
      layout_strategy = 'vertical',
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
         results = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
         preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
         prompt  = { '─', '│', '─', '│', '┌', '┐', '┘', '└' }
      },
      file_ignore_patterns = { 
         'node_modules' 
      }
   }
}
EOF

" Harpoon
lua << EOF
local opts = { silent=true, noremap=true }
vim.api.nvim_set_keymap("n", "<leader>fk", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
vim.api.nvim_set_keymap("n", "<c-m>", ":lua require('harpoon.mark').add_file()<CR>", opts)
vim.api.nvim_set_keymap("n", "<c-o>", ":lua require('harpoon.ui').nav_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<c-i>", ":lua require('harpoon.ui').nav_prev()<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", opts)
EOF

" StatusBar
lua << EOF
local function dynamic_location()
   local line = vim.fn.line('.')
   local column = vim.fn.col('.')
   return string.format('%d:%d', line, column)
end


-- Pending for GruvDark theme
-- ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇
local onedark = require'lualine.themes.onedark'

onedark.normal.a.bg = '#292929'
onedark.normal.b.bg = '#292929'
onedark.normal.c.bg = '#292929'
onedark.normal.a.fg = '#CDC5B8'

onedark.insert.a.bg = '#292929'
onedark.insert.a.fg = '#CDC5B8'
onedark.visual.a.bg = '#292929'
onedark.visual.a.fg = '#CDC5B8'
onedark.command.a.bg = '#292929'
onedark.command.a.fg = '#CDC5B8'

onedark.inactive.c.bg = '#292929'
-- ⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆⬆
-- Pending for GruvDark theme


require('lualine').setup {
   options = {
      icons_enabled = false,
      theme = onedark,
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''}
   },
   sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'filename', 'diff'},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {'selectioncount', 'diagnostics', dynamic_location, 'fileformat', 'encoding'},
      lualine_z = {'progress'}
   }
}
EOF

" ZenMode
lua << EOF
require('zen-mode').setup {
   window = {
      backdrop = 0.94,
      width = 130,
      height = 1,
      options = {
         signcolumn = 'yes',
         number = true,
         relativenumber = true,
         cursorline = false,
         foldcolumn = '0',
         list = false
      }
   }
}
EOF

" Autopairs
lua << EOF
require('nvim-autopairs').setup {}
EOF

" Autotags
lua << EOF
require('nvim-ts-autotag').setup {}
EOF

" Git signs
lua << EOF
require('gitsigns').setup {}
local opts = { silent=true, noremap=true }
vim.api.nvim_set_keymap('n', '<leader>gi', '<cmd>lua require("gitsigns").preview_hunk_inline()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gj', '<cmd>lua require("gitsigns").next_hunk()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gk', '<cmd>lua require("gitsigns").prev_hunk()<CR>', opts)
EOF

" Line indentation
lua << EOF
require('ibl').setup {
   indent = { char = '|' },
   scope = { 
      enabled = true,
      show_start = false,
      show_end = false
   }
}
EOF

" Treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
   ensure_installed = {'vim', 'lua', 'javascript', 'typescript', 'tsx', 'html', 'css', 'json', 'markdown'},
   sync_install = false,
   highlight = {
      enable = true,  
      additional_vim_regex_highlighting = false
   }
}
EOF

" Treesitter highlight
lua <<EOF
require'nvim-treesitter.configs'.setup {
   refactor = {
      highlight_definitions = {
         enable = true,
         -- Set to false if you have an 'updatetime' of ~100.
         clear_on_cursor_move = true
      }
   }
}
EOF

" Lsp-config
lua << EOF
local lsp_zero = require('lsp-zero')
local lsp_attach = function(client, bufnr)
   local opts = {buffer = bufnr}
   vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
   vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
   vim.keymap.set('n', '<leader>ef', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

lsp_zero.extend_lspconfig({
   sign_text = true,
   lsp_attach = lsp_attach,
   capabilities = require('cmp_nvim_lsp').default_capabilities()
})

-- Mason Installed [8]
-- ◍ css-lsp
-- ◍ emmet-language-server
-- ◍ eslint-lsp
-- ◍ html-lsp
-- ◍ json-lsp
-- ◍ marksman
-- ◍ prettierd
-- ◍ stylelint

require('mason').setup({})
require('mason-lspconfig').setup({
   handlers = {
      function(server_name)
         require('lspconfig')[server_name].setup({})
      end
   }
})

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
   completion = {
      -- First suggestion selected
      completeopt = 'menu,menuone,noinsert' 
   },
   sources = {
      -- Mimic vscode suggestions
      {name = 'nvim_lsp'},
      {name = 'buffer', keyword_length = 2},
      {name = 'luasnip', keyword_length = 2},
      {name = 'path'}
   },
   snippet = {
      expand = function(args)
         require('luasnip').lsp_expand(args.body)
      end
   },
   view = { docs = { auto_open = false } },
   mapping = cmp.mapping.preset.insert({ 
      ['<Enter>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping(function() -- Double space due TMUX
         if cmp.visible_docs() then          -- Same in VSCode 
            cmp.close_docs()
         else
            cmp.open_docs()
         end
      end)
   }),
   formatting = lsp_zero.cmp_format({details = false})
})
EOF
