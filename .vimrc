" enable line numbers
set number
set relativenumber

" enable syntax highlighting
syntax on
" colorscheme nord

"Mode Settings

let &t_SI.="\e[6 q" "SI = INSERT mode
let &t_SR.="\e[6 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

"Cursor settings:

"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

"Tab settings:
set tabstop=4 shiftwidth=4 expandtab

"Key mappings:
nmap oo o<Esc>k
