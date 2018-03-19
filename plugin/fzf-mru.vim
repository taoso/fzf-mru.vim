let s:cpo_save = &cpo
set cpo&vim

if !exists('g:fzf_mru_file_list_size')
	let g:fzf_mru_file_list_size = 10
end

if !exists('g:fzf_mru_ignore_patterns')
	let g:fzf_mru_ignore_patterns = 'fugitive\|\.git/\|\_^/tmp/'
end

function! s:ListMruFile()
	let files = map(copy(g:FZF_MRU_FILE_LIST), 'fnamemodify(v:val, ":~:.")')
	let file_len = len(files)
	if file_len == 0
		return
	end
	if file_len > 10
		let file_len = 10
	endif
	let file_len = file_len + 2
	call fzf#run(fzf#wrap({
			\ 'source': files,
			\ 'options': '-m -x +s',
			\ 'down': file_len}))
endfunction

function! s:RecordMruFile()
	let cpath = expand('%:p')
	if !filereadable(cpath)
		return
	endif

	if cpath =~# g:fzf_mru_ignore_patterns
		return
	end

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
	let max_index = g:fzf_mru_file_list_size - 1
	let g:FZF_MRU_FILE_LIST = g:FZF_MRU_FILE_LIST[:max_index]
endfunction

if has('nvim')
	rsh
else
	set viminfo+=!
	if filereadable('~/.viminfo')
		rv
	endif
endif

if !exists('g:FZF_MRU_FILE_LIST')
	let g:FZF_MRU_FILE_LIST = []
endif

augroup FZFMru
  autocmd! BufEnter * call s:ClearCurrentFile()
  autocmd! BufWinLeave,BufWritePost * call s:RecordMruFile()
augroup END

command! FZFMru call s:ListMruFile()

let &cpo = s:cpo_save
unlet s:cpo_save
