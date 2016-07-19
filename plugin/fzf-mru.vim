let s:cpo_save = &cpo
set cpo&vim

function! s:ListMruFile()
	let files = map(copy(g:FZF_MRU_FILE_LIST), 'fnamemodify(v:val, ":~:.")')
	let file_len = len(files)
	if file_len == 0
		return
	elseif file_len > 10
		let file_len = 10
	endif
	let file_len = file_len + 2
	call fzf#run({
			\ 'source': files,
			\ 'sink': 'edit',
			\ 'options': '-m -x +s',
			\ 'down': file_len})
endfunction

function! s:RecordMruFile()
	let cpath = expand('%:p')
	if !filereadable(cpath)
		return
	endif
	if cpath =~ 'fugitive'
		return
	endif
	let idx = index(g:FZF_MRU_FILE_LIST, cpath)
	if idx >= 0
		call filter(g:FZF_MRU_FILE_LIST, 'v:val !=# cpath')
	endif
	call insert(g:FZF_MRU_FILE_LIST, cpath)
endfunction

function! s:ClearCurrentFile()
	let cpath = expand('%:p')
	let idx = index(g:FZF_MRU_FILE_LIST, cpath)
	if idx >= 0
		call remove(g:FZF_MRU_FILE_LIST, idx)
	end
endfunction

if has('nvim')
	rsh
else
	set viminfo+=!
	rv
endif

if !exists('g:FZF_MRU_FILE_LIST')
	let g:FZF_MRU_FILE_LIST = []
endif

autocmd! BufEnter * call s:ClearCurrentFile()
autocmd! BufWinLeave,BufWritePost * call s:RecordMruFile()

command! FZFMru call s:ListMruFile()

let &cpo = s:cpo_save
unlet s:cpo_save
