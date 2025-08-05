" plugins
filetype plugin on

" helper functions
function! s:CommentLine()
  " get the leader, or fall back to "# " if none defined
  let l:leader = substitute(&commentstring, '%s', '', '')
  if empty(l:leader)
    let l:leader = '# '
  endif

  " save cursor in mark z
  normal! mz
    " go to first non‐blank
  normal! ^
    " insert the leader
  execute 'normal! i' . l:leader
    " restore cursor
  normal! `z
endfunction

function! UncommentLine()
  " 1) save cursor
  let l:save = getpos('.')

  " 2) jump to first non‑blank
  normal! ^

  " 3) compute the literal leader (e.g. "# " or "// ")
  let l:leader = substitute(&commentstring, '%s', '', '')
  let l:esc    = escape(l:leader, '\\/.*$^~[]')

  " 4) remove it *where your cursor is* using \%# (cursor‐column atom)
  execute 'silent! s/\%#' . l:esc . '\s\?//'

  " 5) restore cursor
  call setpos('.', l:save)
endfunction
" -----------------------------------------

" enable line numbers
set number
set relativenumber

" enable syntax highlighting
syntax on
" colorscheme nord

"mode settings (cursor options listed below)
"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

let &t_SI.="\e[6 q" "SI = INSERT mode
let &t_SR.="\e[6 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

" indentation settings:
set autoindent
set tabstop=4 shiftwidth=4 expandtab
autocmd FileType css :setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType html :setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType javascript :setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType json :setlocal tabstop=2 shiftwidth=2 expandtab

" comment settings
autocmd FileType c setlocal commentstring=//\%s
autocmd FileType css setlocal commentstring=/*\%s

" key mappings:
nnoremap oo o<Esc>k
nnoremap <silent> s :call <SID>CommentLine()<CR>
nnoremap <silent> S :call UncommentLine()<CR>
