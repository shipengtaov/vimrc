set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
runtime macros/matchit.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


"解决乱码来源网址：http://www.liuhuadong.com/archives/68/index.html
set fileencodings=utf-8,gb2312,gbk,gb18030 
"set termencoding=utf-8
"set encoding=prc
set encoding=utf-8
"if has("win32")
	"set fileencoding=gb2312       ",gbk
"else
	set fileencoding=utf-8
"endif
"文件格式
set fileformats=unix,dos


let mapleader=","
let g:mapleader=","
filetype on
filetype indent on
"filetype off
filetype plugin on
let &termencoding=&encoding
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
language messages zh_CN.utf-8

set guifont=Consolas:h11
set nu
"Set 3 lines to the cursor(scrolloff=5) - when moving vertically using j/k
set so=5
"去掉输入错误时的提示音
"set noerrorbells
"set novisualbell
"set visualbell t_vb=     "这种方式会闪屏
autocmd VimEnter * set visualbell t_vb=
"set tm=500
"普通模式下光标不闪烁
"set gcr=n:block-blinkwait500-blinkoff500-blinkon500
set gcr=n:block-blinkon0
set gcr=i:ver20-blinkwait500-blinkoff500-blinkon500
"可以在buffer的任何地方使用鼠标
set mouse=a
set selection=exclusive
set selectmode=mouse,key

set autoindent
"开启新行时使用智能自动缩进
set smartindent 
"突出显示当前行
"set cursorline
"突出显示当前列
"set cursorcolumn
"增强模式中的命令行自动完成操作
set wildmenu
"设置无备份
set nobackup
"可以在没有保存的情况下切换buffer
set hid
"忽略字母大小写
set ignorecase
 "让vim记忆上次编辑的位置
autocmd BufReadPost *
    \ if line("'\"")>0&&line("'\"")<=line("$") |
    \ exe "normal g'\"" |
    \ endif
set background=dark
"colorscheme solarized
colorscheme molokai
"colorscheme mac_classic
"colorscheme mac_classic
"设置显示每行开头结尾标志
set list
set listchars=tab:▸\ ,eol:¬
"设置默认大小
set lines=32 columns=123

"设置界面
set guioptions=rem
"状态栏
"总是显示状态栏
set laststatus=2
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
"statusline--1
set statusline=%F\ %m%r\ [%{strftime('%Y/%m/%d',getftime(expand('%')))}]%=
set statusline+=%{GetStatusLineInfo()}
if filereadable($VIMFILES . '/plugin/vimbuddy.vim')
 set statusline+=\ %{VimBuddy()}
endif
set statusline+=\ %-21(%11(%l/%L%),%-3v\ %P%)
function GetStatusLineInfo()
 let miscstr = (&spell ? 'spell ' : '')
 let fencstr = (&fenc == '' ? &enc : &fenc) . (&bomb ? '.BOM' : '')
 let textmode = (&et ? '-' : '|') . &ts .
    \ (&cin ? 'c' : (&si ? 's' : (&ai ? 'a' : 'n'))) . &sw .
    \ (&wrap ? 'z' : '-') . &tw
 return miscstr . '[' . &ft . '][' . fencstr . '][' . &ff . '][' . textmode . ']'
endfunction
"statusline-2
"" 状态栏各个状态
"let statusHead ="%-.50f\ %h%m%r"
"let statusBreakPoint ="%<"
"let statusSeparator ="|"
"let statusFileType ="%{((&ft\ ==\ \"help\"\ \|\|\ &ft\ ==\ \"\")?\"\":\"[\".&ft.\"]\")}"
"let statusFileFormat ="[%{(&ff\ ==\ \"unix\")?\"u\":\"d\"}]"
"let statusAscii ="\{%b:0x%B\}"
"let statusCwd ="%-.50{getcwd()}"
"let statusBody =statusFileType.statusFileFormat.statusSeparator.statusAscii.statusSeparator."\ ".statusBreakPoint.statusCwd
"let statusEncoding ="[%{(&fenc\ ==\ \"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]"
"let statusBlank ="%="
"let statusKeymap ="%k"
"let statusRuler ="%-12.(%lL,%c%VC%)\ %P"
"let statusTime ="%{strftime(\"%y-%m-%d\",getftime(expand(\"%\")))}"
"let statusEnd=statusKeymap."\ ".statusEncoding.statusRuler."\ ".statusTime
""" 最终状态栏的模式字符串
"let statusString=statusHead.statusBody.statusBlank.statusEnd
"set statusline=%!statusString 
"
"自动补全选项
set completeopt=menu,longest
"设置vim默认目录
cd d:\wamp\wamp\www
"Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
"execute "NERDTree ".expand('%:p:h')
"au BufWritePost * normal NERDTree %:p:h
"代码折叠
"set fdm=indent
"开启persistent undo
set undofile
set undodir=$VIM/vimfiles/\_undodir

"设置tab和缩进
set shiftwidth=4
set tabstop=4
"set expandtab
"python
au FileType python set expandtab
"au FileType python imap { {}<ESC>i

"MAP映射
"滚动另一个分割窗口
"nnoremap <M-f> <C-w>w<C-f><C-w>w
"nnoremap <M-b> <C-w>w<C-b><C-w>w
""""
"插入模式下移动光标
"inoremap <M-h> <ESC>i
inoremap <M-h> <Left>
cnoremap <M-h> <Left>
inoremap <M-j> <ESC>gja
"inoremap <M-j> <Down>
inoremap <M-k> <ESC>gka
"inoremap <M-k> <Up>
"inoremap <M-l> <ESC>la
inoremap <M-l> <Right>
cnoremap <M-l> <Right>
inoremap <M-a> <ESC>^i
cnoremap <M-a> <HOME>
inoremap <M-e> <ESC>$a
cnoremap <M-e> <END>
"inoremap <M-o> <CR>
"向下插入一行
inoremap <M-o> <ESC>o
"向下插上一行
inoremap <M-O> <ESC>O
inoremap <M-b> <C-Left>
inoremap <M-w> <C-Right>
inoremap <M-d> <ESC>lcw
inoremap <M-<> <Esc>ggi
inoremap <M->> <Esc>Gi
inoremap <M-m> <CR>
"inoremap <M-d> <BACKSPACE>
"inoremap <M-f> <ESC>ld$a
inoremap <C-k> <ESC>ld$a
"撤销
inoremap <C-\> <ESC>ua
"inoremap <C-h> <Left>
"inoremap <C-b> <ESC>i
"inoremap <C-j> <ESC>ja
"inoremap <C-k> <ESC>ka
"inoremap <C-l> <ESC>la
"
"自动补全
inoremap ( ()<ESC>i
"自动补全{}
imap { {}<ESC>i
"imap { {}<ESC>i<CR><ESC>O


"编辑.vimrc文件快捷键
nnoremap <silent> <Leader>ee :e $VIM/_vimrc<CR>

"j,k映射成gj,gk
nnoremap j gj
nnoremap k gk

":映射成;
nnoremap ; :
"
"<ESC>映射取消高亮
nnoremap <ESC> :nohl<return><ESC>
"<F5>显示时间
nnoremap <F5> "=strftime("%Y %b %d %X")<CR>gp
inoremap <F5> <C-R>=strftime("%Y %b %d %X")<CR>
"切换标签页
"inoremap <C-h> <ESC>:tabprevious<CR>
nnoremap <C-h> :tabprevious<CR>
vnoremap <C-h> <ESC>:tabprevious<CR>
"inoremap <C-l> <ESC>:tabnext<CR>
nnoremap <C-l> :tabnext<CR>
vnoremap <C-l> <ESC>:tabnext<CR>
"切换bufer
"nnoremap <C-j> :bn<CR>
"nnoremap <C-k> :bp<CR>
"<tab>映射<C-k>%
nnoremap <tab> %
vnoremap <tab> %
"设置全屏
set winaltkeys=no
nnoremap <M-x> :simalt ~x<CR>
nnoremap <M-r> :simalt ~r<CR>
nnoremap <M-n> :simalt ~n<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"F3 NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"非插入模式下
map <F3> :NERDTreeToggle<CR>
"插入模式下
imap <F3> <ESC> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"FuzzyFinder
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>f :FufFile<CR>
nnoremap <Leader>cf :FufCoverageFile<CR>
nnoremap <Leader>b :FufBuffer<CR>
nnoremap <Leader>d :FufDir<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"pathogen插件管理,pathogen.vim放入vimfiles/autoload
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call pathogen#incubate()
"execute pathogen#infect()
"call pathogen#runtime_append_all_bundles()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vimwiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_use_mouse=1
let g:vimwiki_list=[{'path':'D:/Dropbox/Dropbox/vimwiki/',
			\ 'path_html':'D:/Dropbox/Dropbox/vimwiki/html/',
			\ 'html_header':'D:/Dropbox/Dropbox/vimwiki/template/header.tpl'}]
let g:vimwiki_list_ignore_newline=0
let g:vimwiki_hl_cb_checked=1
let g:vimwiki_menu=''
map <F4> :Vimwiki2HTML<CR>
map <S-F4> :VimwikiAll2HTML<CR>
map <Leader>wq <Plug>VimwikiToggleListItem
"calendar与vimwiki共用一个日记目录
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-LaTex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-javascript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let javascript_enable_domhtmlcss=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"ctags
map <C-F12> :!ctags -R --c++-kinds=+px --fields=+iaS --extra=+q .<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"taglist
"TlistUpdate可以更新tags
""Ctrl-F3 或 <Leader>tl 切换显示 Tlist
map <C-F3> :silent! Tlist<CR>
map <silent> <Leader>tl :Tlist<CR>
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=1 "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
let Tlist_Process_File_Always=0 "是否一直处理tags.1:处理;0:不处理。不是一直实时更新tags，因为没有必要
let Tlist_Inc_Winwidth=0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
