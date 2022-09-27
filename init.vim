" ============= Vim-Plug ============== "{{{

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

"}}}

" ============= Plugins ============== "{{{

call plug#begin(expand('~/.config/nvim/plugged'))
" ================= looks and GUI stuff ================== "{{{

Plug 'joshdick/onedark.vim'                                  " theme
Plug 'vim-airline/vim-airline'                               " theme
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Syntax highlighting

"}}}
" ================= Automatic complement ================== "{{{

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
" Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip'

" For luasnip users.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" For ultisnips users.
" Plug 'SirVer/ultisnips'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" For snippy users.
" Plug 'dcampos/nvim-snippy'
" Plug 'dcampos/cmp-snippy'

"}}}

" ================= lsp ================== "{{{

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'williamboman/mason.nvim'
Plug 'RRethy/vim-illuminate'

"}}}


" ================= DAP ================== "{{{

Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'llmxby/dap-buddy.nvim' , { 'branch': 'feat/master' }
Plug 'leoluz/nvim-dap-go'

"}}}

Plug 'kyazdani42/nvim-web-devicons'                          " optional, for file icons
Plug 'kyazdani42/nvim-tree.lua'                              " file tree
Plug 'fatih/vim-go'                                          " Go
Plug 'kyazdani42/nvim-web-devicons'                          " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }            " tab 
Plug 'moll/vim-bbye'                                         " tab close
Plug 'windwp/nvim-autopairs'                                 " autopairs
Plug 'nvim-lua/plenary.nvim'                                 " Useful lua functions used by lots of plugins
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }     " searching
Plug 'akinsho/toggleterm.nvim'                               " terminals
Plug 'numToStr/Comment.nvim'                                 " comment
Plug 'JoosepAlviste/nvim-ts-context-commentstring'           " comment
Plug 'folke/todo-comments.nvim'                              " todo-comments
Plug 'lewis6991/gitsigns.nvim'                               " git

call plug#end()

"}}}

" ============= General ============== "{{{

set mouse=a                                                  " enable mouse scrolling
set clipboard^=unnamed,unnamedplus                           " Cross-platform value for copy-paste
set incsearch ignorecase smartcase hlsearch                  " highlight text while searching
set history=1000                                             " history limit
set number                                                   " enable numbers on the left
set relativenumber                                           " current line is 0
set noshowmode                                               " dont show current mode below statusline
set termguicolors
set showmatch                                                " Show matching brackets/parenthesis
set noswapfile                                               " no swap files
set noundofile                                               " no undo files
set nobackup                                                 " no backup files

"}}}

" ============= Formatting ============== "{{{

set encoding=utf-8                                           " text encoding
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent          " tab width
set expandtab smarttab                                       " tab key actions
set splitright                                               " open vertical split to the right
set splitbelow                                               " open horizontal split to the bottom

"}}}

" ============= Formatting ============== "{{{

" general
let mapleader = "\<space>"
nnoremap <leader>q :q!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>wq :wq<CR>
" window
nnoremap <A-j> <C-w>j
nnoremap <A-h> <C-w>h
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
noremap <A-m> :NvimTreeToggle<CR>
" bufferline
nnoremap <C-h> :BufferLineCyclePrev<CR> 
nnoremap <C-l> :BufferLineCycleNext<CR> 
nnoremap <C-x> :Bdelete!<CR> 
lua require('user/keymap')

"}}}


" ============= Themeing ============== "{{{
syntax on
let g:airline_theme='onedark'
let g:onedark_termcolors=256
colorscheme onedark

"}}}


" ============= nvim-treesitte ============== "{{{

lua require('user/treesitter')

"}}}



" ================= Automatic complement ================== "{{{

set completeopt=menu,menuone,noselect
lua require('user/cmp')

"}}}

" ================= nvim-tree ================== "{{{

lua require("user/nvim-tree")

"}}}


" ================= bufferline.nvim ================== "{{{

lua <<EOF
require("bufferline").setup{}
-- 下面的配置是为了让标签的位置和vscode查不到
local status, bufferline = pcall(require, "bufferline")
if not status then
    vim.notify("没有找到 bufferline")
  return
end
bufferline.setup({
  options = {
    -- 关闭 Tab 的命令，这里使用 moll/vim-bbye 的 :Bdelete 命令
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    -- 侧边栏配置
    -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
    -- 使用 nvim 内置 LSP  后续课程会配置
    diagnostics = "nvim_lsp",
    -- 可选，显示 LSP 报错图标
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
  },
})
EOF

"}}}

" ================= autopairs ================== "{{{

lua require('user/autopairs')

"}}}

" ================= lsp ================== "{{{

lua require('user/lsp/init')

"}}}

" ================= toggleterm ================== "{{{

lua require('user/toggleterm')

"}}}

" ================= DAP ================== "{{{

lua require('user/dap')

"}}}

" ================= comment ================== "{{{

lua require('user/comment')

"}}}

" ================= mason ================== "{{{

lua require('user/mason')

"}}}

" ================= gitsigns ================== "{{{

lua require('user/gitsigns')

"}}}

