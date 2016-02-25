" start_screen.vim: show any text as a "start screen".
"
" http://code.arp242.net/startscreen.vim
"
" See the bottom of this file for copyright & license information.


"##########################################################
" Initialize some stuff
scriptencoding utf-8
if exists('g:loaded_startscreen') | finish | endif
let g:loaded_startscreen = 1
let s:save_cpo = &cpo
set cpo&vim


"##########################################################
" Options

" The default function; show a fortune
fun! startscreen#fortune()
	.!fortune -a
	silent %>>
	call append('0', "") | call append('0', "")
	:1

	" Moar fortunes! :-)
	nnoremap <buffer> <silent> <Return> :enew<CR>:call startscreen#start()<CR>
endfun

if !exists('g:Startscreen_function')
	let g:Startscreen_function = function('startscreen#fortune')
endif


" Set a fancy start screen
fun! startscreen#start()
	" Don't run if: we have commandline arguments, we don't have an empty
	" buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
	if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
		return
	endif

	" Start a new buffer ...
	enew

	" ... and set some options for it
	setlocal
		\ bufhidden=wipe
		\ buftype=nofile
		\ nobuflisted
		\ nocursorcolumn
		\ nocursorline
		\ nolist
		\ nonumber
		\ noswapfile
		\ norelativenumber

	" Now we can just write to the buffer whatever you want.
	call g:Startscreen_function()

	" No modifications to this buffer
	setlocal nomodifiable nomodified

	" When we go to insert mode start a new buffer, and start insert
	nnoremap <buffer><silent> e :enew<CR>
	nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
	nnoremap <buffer><silent> o :enew <bar> startinsert<CR><CR>
	nnoremap <buffer><silent> p :enew<CR>p
	nnoremap <buffer><silent> P :enew<CR>P
endfun


"##########################################################
" Auto command
augroup startscreen
	autocmd!
	autocmd VimEnter * call startscreen#start()
augroup end


let &cpo = s:save_cpo
unlet s:save_cpo


" The MIT License (MIT)
"
" Copyright © 2016 Martin Tournoij
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to
" deal in the Software without restriction, including without limitation the
" rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
" sell copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" The software is provided "as is", without warranty of any kind, express or
" implied, including but not limited to the warranties of merchantability,
" fitness for a particular purpose and noninfringement. In no event shall the
" authors or copyright holders be liable for any claim, damages or other
" liability, whether in an action of contract, tort or otherwise, arising
" from, out of or in connection with the software or the use or other dealings
" in the software.
