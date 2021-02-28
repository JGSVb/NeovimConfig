let bufferline = {}

let bufferline.icon_close_tab = ''
let bufferline.closable = v:false
let bufferline.icon_separator_active = ''
let bufferline.icon_separator_inactive = ''
let bufferline.icon_tab_modified = '·'

nnoremap <silent> <Tab> :bprevious<CR>
nnoremap <silent> <S-Tab> :bnnext
