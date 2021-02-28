let g:startify_custom_header = readfile(stdpath('config') . '/plugin_config/header.txt')
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_bookmarks = [
    \ '~/Projetos',
    \ '~/Testes',
    \ '~/Scripts'
    \ ]
let g:startify_lists = [
    \ { 'type': 'files',     'header': ['   RECENT']},
    \ { 'type': 'sessions',  'header': ['   SESSIONS']},
    \ { 'type': 'bookmarks', 'header': ['   BOOKMARKS']},
    \ { 'type': 'commands',  'header': ['   COMMANDS']},
    \ ]

let g:startify_padding_left = 4
function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

"augroup StartifyHighlights
"    autocmd BufEnter *
"        \ hi StartifyHeader   gui=bold      guifg=#eb4d4b |
"        \ hi StartifyBracket  gui=italic    guifg=#57606f |
"        \ hi StartifyNumber                 guifg=#ffa502 |
"        \ hi StartifySpecial  gui=italic    guifg=#2ecc71 |
"        \ hi StartifySection  gui=bold      guifg=#fd79a8 |
"augroup END

