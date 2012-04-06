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
au BufNewFile,BufReadPost Rakefile setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
let g:quickrun_config = {}
let g:quickrun_config['ruby.rspec'] = {'command': 'rspec'}
augroup UjihisaRSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

"
" java
"
set tags=~/.tags
set complete=.,w,b,u,t,i
au BufNewFile,BufReadPost *.java setl tabstop=4 softtabstop=4 shiftwidth=4 expandtab
au BufNewFile,BufReadPost *.java setl foldmethod=indent nofoldenable foldlevel=1
let g:quickrun_config['java.test'] = {
\  'exec': [
\    'echo test %s:r:s?[A-z_/-]*/??',
\    'mvn test -Dtest=%s:r:s?[A-z_/-]*/?? || cat target/surefire-reports/*.txt',
\  ],
\}
augroup JUnit
  autocmd!
  autocmd BufWinEnter,BufNewFile *Test.java set filetype=java.test
augroup END

"
" quickrun for TAP result
"
let tap_outputter = quickrun#outputter#buffer#new()
function! tap_outputter.init(session)
  call call(quickrun#outputter#buffer#new().init, [a:session], self)
endfunction
function! tap_outputter.finish(session)
  highlight default TapNotOk ctermfg=White ctermbg=Red guifg=White guibg=Red
  highlight default TapSkip ctermfg=none ctermbg=Yellow guifg=none guibg=Yellow
  call matchadd("TapNotOk","^not ok [1-9]*.*$")
  call matchadd("TapSkip" ,".*# SKIP.*$")
  call call(quickrun#outputter#buffer#new().finish,  [a:session], self)
endfunction
call quickrun#register_outputter("tap_outputter", tap_outputter)
let g:quickrun_config['coffee'] = {'outputter': 'tap_outputter'}
