" Author: Viacheslav Lotsmanov
" License: MIT https://raw.githubusercontent.com/unclechu/neovimrc/master/LICENSE


" applying local additional config
let g:local_guirc_pre = $HOME . '/.neovimrc-gui-local-pre'
if filereadable(g:local_guirc_pre) | exe 'so ' . g:local_guirc_pre | en


" because default map doesn't work in neovim-qt
nn <C-Space> :CtrlSpace<CR>

if !exists('s:is_neovim_gtk_gui')
	let s:is_neovim_gtk_gui = exists('g:GtkGuiLoaded') ? 1 : 0
en

if s:is_neovim_gtk_gui && $TMUX == '' && $GTK_THEME =~ ':light$'
	se bg=light
	cal g:ColorschemeCustomizations()
en

" works for neovim-gtk and for neovim-qt since a250faf from 25-07-2018.
" earlier neovim-qt have been supposed to be run with --no-ext-tabline option.
cal rpcnotify((s:is_neovim_gtk_gui ? 1 : 0), 'Gui', 'Option', 'Tabline', 0)

if s:is_neovim_gtk_gui
	cal rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
	cal rpcnotify(1, 'Gui', 'FontFeatures', 'XHS0, XIDR, XELM, PURS')
el " neovim-qt
	GuiRenderLigatures 1
en

let s:font_family = s:is_neovim_gtk_gui ? 'Iosevka' : 'Iosevka Nerd Font Mono'
let s:font_size = 13

fu! s:update_font()
	if s:is_neovim_gtk_gui " neovim-gtk
		cal rpcnotify(
			\ 1, 'Gui', 'Font', s:font_family.' '.string(s:font_size))
	el " neovim-qt
		cal rpcnotify(
			\ 0, 'Gui', 'Font', s:font_family.':h'.string(s:font_size))
	en
	redr!
endf

fu! s:set_font_family(family)
	let s:font_family = a:family
	cal s:update_font()
endf

com! -nargs=1 GuiFontFamily cal <SID>set_font_family(<args>)

" fast font inc/dec

cal s:update_font()

" too small value may cause freezes because amount of chars is getting extreme
let s:min_size = 9

fu! s:font_size_dec(count)
	let l:count = a:count | if l:count < 1 | let l:count = 1 | en
	let s:font_size = s:font_size - l:count
	if s:font_size < s:min_size | let s:font_size = s:min_size | en
	cal s:update_font()
endf

fu! s:font_size_inc(count)
	let l:count = a:count | if l:count < 1 | let l:count = 1 | en
	let s:font_size = s:font_size + l:count
	if s:font_size < s:min_size | let s:font_size = s:min_size | en
	cal s:update_font()
endf

fu! s:font_size_set(size)
	let s:font_size = str2nr(a:size)
	cal s:update_font()
endf

com! GuiFontSizeDec cal <SID>font_size_dec(1)
com! GuiFontSizeInc cal <SID>font_size_inc(1)
com! -nargs=1 GuiFontSizeDecN cal <SID>font_size_dec(<args>)
com! -nargs=1 GuiFontSizeIncN cal <SID>font_size_inc(<args>)
com! -nargs=1 GuiFontSizeSet cal <SID>font_size_set(<args>)

nn <leader>- :<C-u>cal <SID>font_size_dec(v:count)<CR>
nn <leader>+ :<C-u>cal <SID>font_size_inc(v:count)<CR>
nn <leader>= :<C-u>cal <SID>font_size_inc(v:count)<CR>

let s:scroll_wheel_pace = 5

exe 'nn <expr> <C-ScrollWheelUp>   <SID>font_size_inc('.s:scroll_wheel_pace.')'
exe 'nn <expr> <C-ScrollWheelDown> <SID>font_size_dec('.s:scroll_wheel_pace.')'

exe 'nn <expr> <C-S-ScrollWheelUp>   <SID>font_size_inc('.s:scroll_wheel_pace*2.')'
exe 'nn <expr> <C-S-ScrollWheelDown> <SID>font_size_dec('.s:scroll_wheel_pace*2.')'


" applying local additional config
let g:local_guirc_post = $HOME . '/.neovimrc-gui-local-post'
if filereadable(g:local_guirc_post) | exe 'so ' . g:local_guirc_post | en
