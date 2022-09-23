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

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" For luasnip users.
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'

" For ultisnips users.
" Plug 'SirVer/ultisnips'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" For snippy users.
" Plug 'dcampos/nvim-snippy'
" Plug 'dcampos/cmp-snippy'

"}}}

Plug 'kyazdani42/nvim-web-devicons'                          " optional, for file icons
Plug 'kyazdani42/nvim-tree.lua'                              " file tree
Plug 'fatih/vim-go'                                          " Go
Plug 'kyazdani42/nvim-web-devicons'                          " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }            " tab 
Plug 'moll/vim-bbye'                                         " tab close
Plug 'windwp/nvim-autopairs'                                 " autopairs

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
noremap <C-h> :BufferLineCyclePrev<CR> 
noremap <C-l> :BufferLineCycleNext<CR> 
noremap <C-x> :Bdelete!<CR> 

"}}}


" ============= Themeing ============== "{{{
syntax on
let g:airline_theme='onedark'
let g:onedark_termcolors=256
colorscheme onedark

"}}}


" ============= nvim-treesitte ============== "{{{

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "go", "lua", "gomod" , "gowork" , "json" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {  },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- 启用增量选择
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      scope_incremental = '<TAB>',
    }
  },
}
-- 开启 Folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.wo.foldlevel = 99
EOF

"}}}



" ================= Automatic complement ================== "{{{

set completeopt=menu,menuone,noselect
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      -- 上一个
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      -- 下一个
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<A-.>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true ,
      behavior = cmp.ConfirmBehavior.Install }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })


  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    capabilities = capabilities
  }
EOF

"}}}

" ================= nvim-tree ================== "{{{

lua <<EOF
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup()
EOF

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

lua << EOF
require("nvim-autopairs").setup {}
-- insert `(` after select function or method item for nvim-cmp
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok,cmp=pcall(require,"cmp")
if not cmp_status_ok then
    return
end
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done {map_char = {tex = ''}})
EOF

"}}}
