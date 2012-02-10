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
nmap <silent> <C-c> :write<CR>:!cake<CR>

"
" ruby & RSpec
"
au BufNewFile,BufReadPost *.rb setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
let g:quickrun_config = {}
let g:quickrun_config['ruby.rspec'] = {'command': 'rspec'}
augroup UjihisaRSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END
