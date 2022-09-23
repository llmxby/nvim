-- ============= Vim-Plug ============== {{{

-- auto-install vim-plug
vim.command [[
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
]]

--}}}

-- ============= Plugins ============== {{{
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- ================= looks and GUI stuff ================== "{{{

Plug 'joshdick/onedark.vim'                                      -- theme
Plug 'vim-airline/vim-airline'                                   -- theme
Plug ('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})    -- Syntax highlighting

--}}}

Plug 'scrooloose/nerdtree'                                       -- 目录树
Plug 'fatih/vim-go'                                              -- Go常用功能

vim.call('plug#end')

--}}}

-- ============= General ============== {{{

local set = vim.opt
set.mouse=a                                                      -- enable mouse scrolling
set.clipboard^=unnamed,unnamedplus                               -- Cross-platform value for copy-paste
set.history=1000                                                 -- history limit
set.number=true                                                  -- enable numbers on the left
set.relativenumber=true                                          -- current line is 0
set.noshowmode=true                                              -- dont show current mode below statusline
set.termguicolors=true

--}}}

-- ============= Formatting ============== {{{

set.encoding=utf-8                                               -- text encoding
set.tabstop=4 set.softtabstop=4 set.shiftwidth=4 set.autoindent  -- tab width
set.expandtab=true set.smarttab=true                             -- tab key actions
set.splitright=true                                              -- open vertical split to the right
set.splitbelow=true                                              -- open horizontal split to the bottom

--}}}


-- ============= Themeing ============== {{{

vim.command "let g:airline_theme=\"onedark\""
vim.command "syntax on"
vim.command "let g:onedark_termcolors=256"
vim.command "colorscheme onedark"

-- "}}}


-- ============= nvim-treesitte ============== "{{{

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "go", "lua", "gomod" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

--}}}
