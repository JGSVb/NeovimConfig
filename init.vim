filetype off     " Para algum plugin que eu não me lembro
set nocompatible " Para algum plugin que eu não me lembro
set hidden       " Para usar o NNN


""""""""""""""""""""""""""""
" Configurações de Plugins "
""""""""""""""""""""""""""""

source $HOME/.config/nvim/plugin_config/vim-plug.vim
source $HOME/.config/nvim/plugin_config/vundle.vim
source $HOME/.config/nvim/plugin_config/startify.vim
source $HOME/.config/nvim/plugin_config/airline.vim
source $HOME/.config/nvim/plugin_config/nerdtree.vim
source $HOME/.config/nvim/plugin_config/barbar.vim
source $HOME/.config/nvim/plugin_config/ycm.vim
source $HOME/.config/nvim/plugin_config/floaterm.vim
source $HOME/.config/nvim/plugin_config/nnn.vim


"""""""""""""""""""""""""""
" Configurações de Estilo "
"""""""""""""""""""""""""""

" Configurações do one dark
let g:onedark_terminal_italics = 1
let g:onedark_hide_endofbuffer = 1

" Configurações do Tokyo Night
let g:tokyonight_style = 'storm'
let g:tokyonight_enable_italic = 1

" Srcery
let g:srcery_italic = 1

" Embark
let g:embark_terminal_italics = 1

" Gruvbox
let gruvbox_contrast_dark = 'hard'


" Mostrar os números
set number

" Números relativos à linha atual
set relativenumber

" Cores RGB24
set termguicolors

colorscheme gruvbox

syntax on

au BufEnter *.c* syn keyword cType const |
			\ set autoindent   |
			\ set noexpandtab  |
			\ set tabstop=2    |
			\ set shiftwidth=2

""""""""""
" Outros "
""""""""""

" scroll offset 
set scrolloff=10
