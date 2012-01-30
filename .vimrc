set number
set tabstop=4
set fileencodings=utf-8

filetype on
syntax on

"
" CoffeeScript
"
au BufNewFile,BufReadPost *.coffee setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

nmap <silent> <C-c> :write<CR>:!cake build<CR>
