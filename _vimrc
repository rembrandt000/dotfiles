"----------------------------------------------------
" ��{�I�Ȑݒ�
"----------------------------------------------------
"Vi�݊����I�t
set nocompatible
"�N���b�v�{�[�h��Windows�ƘA�g
set clipboard=unnamed
" ���s�R�[�h�̎����F��
set fileformats=unix,dos,mac

"----------------------------------------------------
" �o�b�N�A�b�v�֌W
"----------------------------------------------------
" �o�b�N�A�b�v���Ƃ�Ȃ�
set nobackup
" �t�@�C���̏㏑���̑O�Ƀo�b�N�A�b�v�����
" (�������Abackup ���I���łȂ�����A�o�b�N�A�b�v�͏㏑���ɐ���������폜�����)
set writebackup
" �o�b�N�A�b�v���Ƃ�ꍇ
"set backup
" �o�b�N�A�b�v�t�@�C�������f�B���N�g��
"set backupdir=~/backup
" �X���b�v�t�@�C�������f�B���N�g��
"set directory=~/swap

"----------------------------------------------------
" �����֌W
"----------------------------------------------------
" �R�}���h�A�����p�^�[����100�܂ŗ����Ɏc��
set history=100
" �����̎��ɑ啶������������ʂ��Ȃ�
set ignorecase
" �����̎��ɑ啶�����܂܂�Ă���ꍇ�͋�ʂ��Č�������
set smartcase
" �Ō�܂Ō���������擪�ɖ߂�
set wrapscan
" �C���N�������^���T�[�`���g��Ȃ�
" set noincsearch

"----------------------------------------------------
" �\���֌W
"----------------------------------------------------
" �^�C�g�����E�C���h�E�g�ɕ\������
set title
" �s�ԍ���\�����Ȃ�
set nonumber
" ���[���[��\�� (noruler:��\��)
set ruler
" �^�u������ CTRL-I �ŕ\�����A�s���� $ �ŕ\������
" set list
" ���͒��̃R�}���h���X�e�[�^�X�ɕ\������
set showcmd
" �X�e�[�^�X���C������ɕ\��
set laststatus=2
" ���ʓ��͎��̑Ή����銇�ʂ�\��
set showmatch
" �Ή����銇�ʂ̕\�����Ԃ�2�ɂ���
set matchtime=2
" �V���^�b�N�X�n�C���C�g��L���ɂ���
syntax on
" �������ʕ�����̃n�C���C�g��L���ɂ���
set hlsearch
" �R�����g���̐F��ύX
highlight Comment ctermfg=DarkCyan
" �R�}���h���C���⊮���g�����[�h�ɂ���
set wildmenu
"�J�[�\�����s���A�s���Ŏ~�܂�Ȃ��悤�ɂ���
set whichwrap=b,s,h,l,<,>,[,]

" ���͂���Ă���e�L�X�g�̍ő啝
" (�s�������蒷���Ȃ�ƁA���̕��𒴂��Ȃ��悤�ɋ󔒂̌�ŉ��s�����)�𖳌��ɂ���
set textwidth=0
" �E�B���h�E�̕���蒷���s�͐܂�Ԃ��āA���̍s�ɑ����ĕ\������
set wrap

" �S�p�X�y�[�X�̕\��
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /�@/

" �X�e�[�^�X���C���ɕ\��������̎w��
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>
" �X�e�[�^�X���C���̐F
highlight StatusLine   term=NONE cterm=NONE ctermfg=black ctermbg=white

" Esc��2�񉟂��Ńn�C���C�g����
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>


"---------------------------------------------------------------------------
" �^�u�ݒ�
"---------------------------------------------------------------------------
" �^�u�y�[�W�̃��C���\��
" 0���w�肵���ꍇ�͏�ɔ�\���A
" 1�Ȃ�2�ȏ�^�u�y�[�W������ꍇ�ɕ\���A
" 2�Ȃ��ɕ\��
set showtabline=1

"----------------------------------------------------
" �C���f���g
"----------------------------------------------------
" �I�[�g�C���f���g�𖳌��ɂ���
"set noautoindent
" �^�u���Ή�����󔒂̐�
set tabstop=4
" �^�u��o�b�N�X�y�[�X�̎g�p���̕ҏW���������Ƃ��ɁA�^�u���Ή�����󔒂̐�
set softtabstop=4
" �C���f���g�̊e�i�K�Ɏg����󔒂̐�
set shiftwidth=4
" �^�u��}������Ƃ��A����ɋ󔒂��g��Ȃ�
" set noexpandtab

"���̓��[�h���A�X�e�[�^�X���C���̃J���[��ύX
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END
"���{����͂����Z�b�g
au BufNewFile,BufRead * set iminsert=0

"----------------------------------------------------
" ���ۉ��֌W
"----------------------------------------------------
" �����R�[�h�̐ݒ�
" fileencodings�̐ݒ�ł�encoding�̒l����ԍŌ�ɋL�q����
set encoding=utf-8
scriptencoding cp932
"set termencoding=utf-8
set termencoding=cp932
set fileencoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
" set fileencodings+=,ucs-2le,ucs-2,utf-8

"----------------------------------------------------
" �I�[�g�R�}���h
"----------------------------------------------------
if has("autocmd")
    " �t�@�C���^�C�v�ʃC���f���g�A�v���O�C����L���ɂ���
    filetype plugin indent on
    " �J�[�\���ʒu���L������
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
endif

"----------------------------------------------------
" ���̑�
"----------------------------------------------------
" �o�b�t�@��ؑւ��Ă�undo�̌��͂�����Ȃ�
set hidden
" �N�����̃��b�Z�[�W��\�����Ȃ�
set shortmess+=I
" �f�B���N�g���{�����̕\�����c���[�`���ɂ���
let g:netrw_liststyle=3

"----------------------------------------------------
" �L�[�o�C���h
"----------------------------------------------------
" C-k �ŃN���b�v�{�[�h��\���
imap <C-k> <C-r>*
map <C-k> "*p
" �}�����[�h���� C-l �ŃC���f���g�폜
inoremap <C-l> <C-d>
" �}�����[�h���� emacs���̃L�[�o�C���h��
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
" �o�b�t�@������t�@���N�V�����L�[��
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>
" �^�u������t�@���N�V�����L�[��
map <F7> <ESC>:tabnew<CR>
map <F8> <ESC>:tabp<CR>
map <F9> <ESC>:tabn<CR>
" �m�[�}�����[�h���̍s���ړ��� �u;�v�ɂ���
noremap ; $
" �m�[�}�����[�h���� Y �ŃJ�[�\���ʒu����s���܂ŃR�s�[
map Y v$y
" Ctrl+Shift+N(P)�ŏ�ɕ\�����Ă���E�B���h�E���X�N���[��������
nnoremap <C-S-N> <C-W>k<C-E><C-W>j
nnoremap <C-S-P> <C-W>k<C-Y><C-W>j
" �}�����[�h���� ESC ��IME���m����OFF
inoremap <ESC> <ESC>:set iminsert=0<CR>
" Leader���X�y�[�X�ɐݒ�
let mapleader=" "
" q�ŃE�C���h�E����� Q�Ń}�N��
nnoremap q :<C-u>q<CR>
nnoremap Q q



"----------------------------------------------------
" neobundle�ݒ�
"----------------------------------------------------
" ���ϐ���git�̃p�X��ʂ�
let $PATH = "C:/bin/ConEmuPack/app/nayos3/bin" . ';' . "C:/bin/ConEmuPack/app/git/bin" . ';' . $PATH

filetype off

" vim�N�����̂�runtimepath��neobundle.vim��ǉ�
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/vimfiles/bundle/neobundle.vim
endif

" neobundle.vim�̏����� 
" call neobundle#rc(expand('~/vimfiles/bundle/'))
call neobundle#begin(expand('~/vimfiles/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

" NeoBundle���X�V���邽�߂̐ݒ�

" NeoBundle �ŊǗ�����v���O�C����ǉ����܂��B" �ǂݍ��ރv���O�C�����L��
NeoBundle 'Shougo/neocomplete.vim' 
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'haya14busa/vim-migemo'
NeoBundle 'itchyny/lightline.vim'

" �C���X�g�[���̃`�F�b�N
NeoBundleCheck

" �ǂݍ��񂾃v���O�C�����܂߁A�t�@�C���^�C�v�̌��o�A�t�@�C���^�C�v�ʃv���O�C��/�C���f���g��L��������
syntax on
filetype plugin indent on


" ~/neobundle.log �Ƀ��O���o�͂���
let g:neobundle#log_filename = $HOME . "/neobundle.log"



"----------------------------------------------------
" migemo�ݒ�
"----------------------------------------------------
map <C-M> g/

"----------------------------------------------------
" QFixHowm�ݒ�
"----------------------------------------------------
" qfixapp��runtimepath��ʂ�(�p�X�͊��ɍ��킹�Ă�������)
" set runtimepath+=c:/temp/qfixapp
let QFixHowm_ListAutoClose = 1
" QFixHowm ���j���[�\���ŃJ�����_�[on/off
let QFixHowm_MenuCalendar = 0

" �L�[�}�b�v���[�_�[
let QFixHowm_Key = 'g'

" MRU�̊�f�B���N�g
" let QFixMRU_Rootdir      = 'C:/users/908658/Dropbox/soft/howm'
let QFixMRU_Rootdir      = '~/Dropbox/soft/howm'
" MRU�̕ۑ��t�@�C����
" let QFixMRU_Filename     = 'C:/users/908658/Dropbox/soft/vim/.qfixmru'
let QFixMRU_Filename     = '~/Dropbox/soft/vim/.qfixmru'
" howm_dir�̓t�@�C����ۑ��������f�B���N�g����ݒ�
" let QFixHowm_Rootdir     = 'C:/users/908658/Dropbox/soft/howm'
let QFixHowm_Rootdir     = '~/Dropbox/soft/howm'
" let howm_dir             = 'C:/users/908658/Dropbox/soft/howm'
let howm_dir             = '~/Dropbox/soft/howm'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding    = 'utf8'
let howm_fileformat      = 'dos'
" QFixHowm�̃t�@�C���^�C�v
let QFixHowm_FileType = 'qfix_memo'
let QFixHowm_FileType = 'markdown'
" �L�[�R�[�h��}�b�s���O���ꂽ�L�[�񂪊�������̂�҂���(�~���b)
set timeoutlen=3500
" GMT�Ƃ̎���
let QFixHowm_ST = +9
" grep
" let mygrepprg = 'findstr'
" let mygrepprg='c:/bin/ckw/bin/grep.exe'
let mygrepprg = 'agrep.vim'
" grep�Ώۂɂ������Ȃ��t�@�C�����̐��K�\��
let MyGrep_ExcludeReg = '[~#]$\|\.dll$\|\.exe$\|\.lnk$\|\.o$\|\.obj$\|\.pdf$\|\.xls$\|__submenu__\|00-00-000\|\.swp$'


"----------------------------------------------------
" ambsearch�ݒ�
"----------------------------------------------------
" ambsearch.vim��ǂݍ���
:source $HOME/vimfiles/bundle/ambsearch-20040211/ambsearch.vim

"----------------------------------------------------
" �V�F���w�� (NYAOS)
"----------------------------------------------------
" set shell=C:\WINDOWS\system32\cmd.exe
set shell=c:\bin\ConEmuPack\app\nyaos3\nyaos.exe
" set shellcmdflag=-e
set shellpipe=\|&\ tee
" set shellpipe=
" set shellredir=>%s\ 2>&1
" set shellxquote=\"
set noshellslash

"----------------------------------------------------
" NERDTree�ݒ�
"----------------------------------------------------
" �J�����g�f�B���N�g���ύX
":set browsedir=~/Dropbox/
:cd ~/Dropbox/
" <F10> �� NERDTree�N��
nnoremap <F10> <ESC>:NERDTreeToggle<CR>
set grepprg=internal



"----------------------------------------------------
" vimfiler
"----------------------------------------------------
command Vf VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit
" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'
"�f�t�H���g��IDE����Filer���J��
" autocmd VimEnter * VimFiler -split -simple -winwidth=30 -no-quit
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default=0
let g:netrw_liststyle=3


"----------------------------------------------------
" pathogen�ݒ�
"----------------------------------------------------
execute pathogen#infect()


"----------------------------------------------------
" over.vim�ݒ�
"----------------------------------------------------
nnoremap <silent> <Leader>m :OverCommandLine<CR>
" �J�[�\�����̒P����n�C���C�g�t���Œu��
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
" �R�s�[������������n�C���C�g�t���Œu��
nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>



"----------------------------------------------------
" unite.vim�̐ݒ�
"----------------------------------------------------
" ���̓��[�h�ŊJ�n����
let g:unite_enable_start_insert=1
" �o�b�t�@�ꗗ
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" �t�@�C���ꗗ
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" ���W�X�^�ꗗ
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" �ŋߎg�p�����t�@�C���ꗗ
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" Qfixhowm�ꗗ
nnoremap <silent> ,uq :<C-u>Unite qfixhowm<CR>
" ��p�Z�b�g
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" �S���悹
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file qfixhowm<CR>
" �E�B���h�E�𕪊����ĊJ��
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" �E�B���h�E���c�ɕ������ĊJ��
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESC�L�[��2�񉟂��ƏI������
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
"�ŋߊJ�����t�@�C�������̕ۑ���
let g:unite_source_file_mru_limit = 50




"----------------------------------------------------
" w3m.vim
"----------------------------------------------------
" let g:w3m#command = 'C:\bin\xyzzy\site-lisp\www\w3m\w3m.exe'
" nnoremap <leader>w :W3mTab C:\bin\xyzzy\etc\bookmark.html



"----------------------------------------------------
" gmail.vim
"----------------------------------------------------
let g:gmail_imap = 'px4.cloudgate.jp:10906'
let g:gmail_smtp = 'px4.cloudgate.jp:10902'
let g:gmail_user_name = 'takakusa.yasuo@rene-easton.com'



"----------------------------------------------------
" vimorganizer
"----------------------------------------------------
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org            call org#SetOrgFileType()
let g:org_command_for_emacsclient = 'C:\bin\emacs\bin\emacsclientw.exe'
let g:org_agenda_select_dirs=["~/Dropbox/soft/howm/org"]
let g:org_agenda_files = split(glob("~/Dropbox/soft/howm/org/*.org"),"\n")
