__Archived. Use [mru](https://github.com/lvht/mru) instead.__

# fzf-mru

Most Recently Used File List for Vim/NeoVim based on [FZF](https://github.com/junegunn/fzf).

As discussed at https://github.com/junegunn/fzf/pull/624 , this mru feature 
could not to be accepted. And I have to make this repo.

# Install

```
Plug 'lvht/fzf-mru'|Plug 'junegunn/fzf'


" set max lenght for the mru file list
let g:fzf_mru_file_list_size = 10 " default value
" set path pattens that should be ignored
let g:fzf_mru_ignore_patterns = 'fugitive\|\.git/\|\_^/tmp/' " default value
```

# Usage

fzf-mru offers a `FZFMru` command which will open a list to show your
most recently used file list. 

fzf-mru depends the vim's viminfo or neovim's shada. please confirm your 
vim/neovim has been compiled with these feature.


# Story
There is also another plugin called [fzf-filemru](https://github.com/tweekmonster/fzf-filemru)
by [tweekmonster](https://github.com/tweekmonster). But the fzf-filemru 
use the **$XDG_CACHE_HOME/fzf_filemru** to store the file list,
the external [filemru.sh](https://github.com/tweekmonster/fzf-filemru/blob/master/bin/filemru.sh) script
to record file list, which is a little heavyweight.

I alsa want to make a PR to tweekmonster. But it will almost be an rewrite PR, 
and I do not think tweekmonster will accept.

This is story of fzf-mru.

Enjoy yourself :).
