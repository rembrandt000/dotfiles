"----------------------------------------------------
" 基本的な設定
"----------------------------------------------------
"Vi互換をオフ
set nocompatible
"クリップボードをWindowsと連携
set clipboard=unnamed
" 改行コードの自動認識
set fileformats=unix,dos,mac

"----------------------------------------------------
" バックアップ関係
"----------------------------------------------------
" バックアップをとらない
set nobackup
" ファイルの上書きの前にバックアップを作る
" (ただし、backup がオンでない限り、バックアップは上書きに成功した後削除される)
set writebackup
" バックアップをとる場合
"set backup
" バックアップファイルを作るディレクトリ
"set backupdir=~/backup
" スワップファイルを作るディレクトリ
"set directory=~/swap

"----------------------------------------------------
" 検索関係
"----------------------------------------------------
" コマンド、検索パターンを100個まで履歴に残す
set history=100
" 検索の時に大文字小文字を区別しない
set ignorecase
" 検索の時に大文字が含まれている場合は区別して検索する
set smartcase
" 最後まで検索したら先頭に戻る
set wrapscan
" インクリメンタルサーチを使わない
" set noincsearch

"----------------------------------------------------
" 表示関係
"----------------------------------------------------
" タイトルをウインドウ枠に表示する
set title
" 行番号を表示しない
set nonumber
" ルーラーを表示 (noruler:非表示)
set ruler
" タブ文字を CTRL-I で表示し、行末に $ で表示する
" set list
" 入力中のコマンドをステータスに表示する
set showcmd
" ステータスラインを常に表示
set laststatus=2
" 括弧入力時の対応する括弧を表示
set showmatch
" 対応する括弧の表示時間を2にする
set matchtime=2
" シンタックスハイライトを有効にする
syntax on
" 検索結果文字列のハイライトを有効にする
set hlsearch
" コメント文の色を変更
highlight Comment ctermfg=DarkCyan
" コマンドライン補完を拡張モードにする
set wildmenu
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

" 入力されているテキストの最大幅
" (行がそれより長くなると、この幅を超えないように空白の後で改行される)を無効にする
set textwidth=0
" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" ステータスラインに表示する情報の指定
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>
" ステータスラインの色
highlight StatusLine   term=NONE cterm=NONE ctermfg=black ctermbg=white

" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>


"---------------------------------------------------------------------------
" タブ設定
"---------------------------------------------------------------------------
" タブページのライン表示
" 0を指定した場合は常に非表示、
" 1なら2つ以上タブページがある場合に表示、
" 2なら常に表示
set showtabline=1

"----------------------------------------------------
" インデント
"----------------------------------------------------
" オートインデントを無効にする
"set noautoindent
" タブが対応する空白の数
set tabstop=4
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=4
" インデントの各段階に使われる空白の数
set shiftwidth=4
" タブを挿入するとき、代わりに空白を使わない
" set noexpandtab

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END
"日本語入力をリセット
au BufNewFile,BufRead * set iminsert=0

"----------------------------------------------------
" 国際化関係
"----------------------------------------------------
" 文字コードの設定
" fileencodingsの設定ではencodingの値を一番最後に記述する
set encoding=utf-8
scriptencoding cp932
"set termencoding=utf-8
set termencoding=cp932
set fileencoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
" set fileencodings+=,ucs-2le,ucs-2,utf-8

"----------------------------------------------------
" オートコマンド
"----------------------------------------------------
if has("autocmd")
    " ファイルタイプ別インデント、プラグインを有効にする
    filetype plugin indent on
    " カーソル位置を記憶する
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
endif

"----------------------------------------------------
" その他
"----------------------------------------------------
" バッファを切替えてもundoの効力を失わない
set hidden
" 起動時のメッセージを表示しない
set shortmess+=I
" ディレクトリ閲覧時の表示をツリー形式にする
let g:netrw_liststyle=3

"----------------------------------------------------
" キーバインド
"----------------------------------------------------
" C-k でクリップボードを貼りつけ
imap <C-k> <C-r>*
map <C-k> "*p
" 挿入モード時に C-l でインデント削除
inoremap <C-l> <C-d>
" 挿入モード時に emacs風のキーバインドに
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
" バッファ操作をファンクションキーで
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>
" タブ操作をファンクションキーで
map <F7> <ESC>:tabnew<CR>
map <F8> <ESC>:tabp<CR>
map <F9> <ESC>:tabn<CR>
" ノーマルモード時の行末移動を 「;」にする
noremap ; $
" ノーマルモード時に Y でカーソル位置から行末までコピー
map Y v$y
" Ctrl+Shift+N(P)で上に表示しているウィンドウをスクロールさせる
nnoremap <C-S-N> <C-W>k<C-E><C-W>j
nnoremap <C-S-P> <C-W>k<C-Y><C-W>j
" 挿入モード時の ESC でIMEを確実にOFF
inoremap <ESC> <ESC>:set iminsert=0<CR>
" Leaderをスペースに設定
let mapleader=" "
" qでウインドウを閉じて Qでマクロ
nnoremap q :<C-u>q<CR>
nnoremap Q q



"----------------------------------------------------
" neobundle設定
"----------------------------------------------------
" 環境変数にgitのパスを通す
let $PATH = "C:/bin/ConEmuPack/app/nayos3/bin" . ';' . "C:/bin/ConEmuPack/app/git/bin" . ';' . $PATH

filetype off

" vim起動時のみruntimepathにneobundle.vimを追加
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/vimfiles/bundle/neobundle.vim
endif

" neobundle.vimの初期化 
" call neobundle#rc(expand('~/vimfiles/bundle/'))
call neobundle#begin(expand('~/vimfiles/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

" NeoBundleを更新するための設定

" NeoBundle で管理するプラグインを追加します。" 読み込むプラグインを記載
NeoBundle 'Shougo/neocomplete.vim' 
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'haya14busa/vim-migemo'
NeoBundle 'itchyny/lightline.vim'

" インストールのチェック
NeoBundleCheck

" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化する
syntax on
filetype plugin indent on


" ~/neobundle.log にログを出力する
let g:neobundle#log_filename = $HOME . "/neobundle.log"



"----------------------------------------------------
" migemo設定
"----------------------------------------------------
map <C-M> g/

"----------------------------------------------------
" QFixHowm設定
"----------------------------------------------------
" qfixappにruntimepathを通す(パスは環境に合わせてください)
" set runtimepath+=c:/temp/qfixapp
let QFixHowm_ListAutoClose = 1
" QFixHowm メニュー表示でカレンダーon/off
let QFixHowm_MenuCalendar = 0

" キーマップリーダー
let QFixHowm_Key = 'g'

" MRUの基準ディレクト
" let QFixMRU_Rootdir      = 'C:/users/908658/Dropbox/soft/howm'
let QFixMRU_Rootdir      = '~/Dropbox/soft/howm'
" MRUの保存ファイル名
" let QFixMRU_Filename     = 'C:/users/908658/Dropbox/soft/vim/.qfixmru'
let QFixMRU_Filename     = '~/Dropbox/soft/vim/.qfixmru'
" howm_dirはファイルを保存したいディレクトリを設定
" let QFixHowm_Rootdir     = 'C:/users/908658/Dropbox/soft/howm'
let QFixHowm_Rootdir     = '~/Dropbox/soft/howm'
" let howm_dir             = 'C:/users/908658/Dropbox/soft/howm'
let howm_dir             = '~/Dropbox/soft/howm'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding    = 'utf8'
let howm_fileformat      = 'dos'
" QFixHowmのファイルタイプ
let QFixHowm_FileType = 'qfix_memo'
let QFixHowm_FileType = 'markdown'
" キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set timeoutlen=3500
" GMTとの時差
let QFixHowm_ST = +9
" grep
" let mygrepprg = 'findstr'
" let mygrepprg='c:/bin/ckw/bin/grep.exe'
let mygrepprg = 'agrep.vim'
" grep対象にしたくないファイル名の正規表現
let MyGrep_ExcludeReg = '[~#]$\|\.dll$\|\.exe$\|\.lnk$\|\.o$\|\.obj$\|\.pdf$\|\.xls$\|__submenu__\|00-00-000\|\.swp$'


"----------------------------------------------------
" ambsearch設定
"----------------------------------------------------
" ambsearch.vimを読み込む
:source $HOME/vimfiles/bundle/ambsearch-20040211/ambsearch.vim

"----------------------------------------------------
" シェル指定 (NYAOS)
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
" NERDTree設定
"----------------------------------------------------
" カレントディレクトリ変更
":set browsedir=~/Dropbox/
:cd ~/Dropbox/
" <F10> で NERDTree起動
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
"デフォルトでIDE風のFilerを開く
" autocmd VimEnter * VimFiler -split -simple -winwidth=30 -no-quit
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default=0
let g:netrw_liststyle=3


"----------------------------------------------------
" pathogen設定
"----------------------------------------------------
execute pathogen#infect()


"----------------------------------------------------
" over.vim設定
"----------------------------------------------------
nnoremap <silent> <Leader>m :OverCommandLine<CR>
" カーソル下の単語をハイライト付きで置換
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
" コピーした文字列をハイライト付きで置換
nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>



"----------------------------------------------------
" unite.vimの設定
"----------------------------------------------------
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" Qfixhowm一覧
nnoremap <silent> ,uq :<C-u>Unite qfixhowm<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file qfixhowm<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
"最近開いたファイル履歴の保存数
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
