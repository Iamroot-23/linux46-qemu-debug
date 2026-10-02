set diffopt+=iwhite
" set noimd	" ESC 한글 영문 설정
" set langmap=ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz

set nu
set ai
set si
set ci
" set sw=8 ts=8 sts=8	"<F8>일반용, <F9>:커널 분석용
set ts=4 sts=4 sw=4
" autocmd FileType python setlocal ts=4 sts=4 sw=4
" autocmd FileType c setlocal ts=8 sts=8 sw=8
"set ignorecase
set hlsearch
"set expandtab
"set bg=dark
set nocompatible
set fileencodings=utf-8,euc-kr
set history=1000
set ruler
set nobackup
set title
set showmatch
set nowrap
set wmnu
set mouse=

set ls=2	"last statusbar

syntax on
set cc=80	" 80라인 컬럼 표시

" set dy+=lastline
" set formatoptions+=r    " 주석 자동 처리
" setlocal comments-=://  " // 자동 주석 제거
" colorscheme ron
"============= vim 창 크기 조절 ============
"nmap <s-h> <C-W><
"nmap <s-j> <C-W>-
"nmap <s-k> <C-W>+
"nmap <s-l> <C-W>>

"============= vim 창이동 ============
nmap <c-k> <c-w>k
nmap <c-j> <c-w>j
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l

"===== 버퍼간 이동
nmap ,x :bn!<CR>	  " Switch to Next File Buffer
nmap ,z :bp!<CR>	  " Switch to Previous File Buffer
nmap ,w :bw<CR>	  " Close Current File Buffer

nmap ,1 :b!1<CR>	  " Switch to File Buffer #1
nmap ,2 :b!2<CR>	  " Switch to File Buffer #2
nmap ,3 :b!3<CR>	  " Switch to File Buffer #3
nmap ,4 :b!4<CR>	  " Switch to File Buffer #4
nmap ,5 :b!5<CR>	  " Switch to File Buffer #5
nmap ,6 :b!6<CR>	  " Switch to File Buffer #6
nmap ,7 :b!7<CR>	  " Switch to File Buffer #7
nmap ,8 :b!8<CR>	  " Switch to File Buffer #8
nmap ,9 :b!9<CR>	  " Switch to File Buffer #9
nmap ,0 :b!0<CR>	  " Switch to File Buffer #0


"============ kernel source 경로 ===========
let kernel_src_home=$PWD
"============ ctags, scope 경로 ===========
if filereadable(kernel_src_home . "/cscope.out")
	set sw=8 ts=8 sts=8	"<F8>일반용, <F9>:커널 분석용
	exe "set tags+=" . kernel_src_home . "/tags"
	exe "cscope add " . kernel_src_home . "/cscope.out"
endif

set csprg=/usr/bin/cscope
set nocsverb
set csverb
set csto=0
set csre
set cst


"============= ctags 설정 ============
if version >= 500

"수평 분할 태그 점프(tag jump)
func! Sts()
	let st = expand("<cword>")
	exe "sts ".st
endfunc
nmap ,st :call Sts()<cr>

"새 버퍼로 태그 점프(tag jump)
func! Tj()
	let st = expand("<cword>")
	exe "tj ".st
endfunc
nmap ,tj :call Tj()<cr>
endif

nmap ,tp :tp <cr>   " 이전 태그로 이동
nmap ,tn :tn <cr>   " 다음 태그로 이동

"============= cscope 설정 ===========
"Find this C Symbol
func! Css()
	let css = expand("<cword>")
	" new
	exe "cs find s ".css
	if getline(1) == ""
		exe "q!"
	endif
endfunc
nmap ,css :call Css() <cr>

"Find functions calling this function
func! Csc()
	let csc = expand("<cword>")
	"new
	exe "cs find c ".csc
	if getline(1) == ""
		exe "q!"
	endif
endfunc
nmap ,csc :call Csc() <cr>

"Find functions called by this function
func! Csd()
	let csd = expand("<cword>")
	"new
	exe "cs find d ".csd
	if getline(1) == ""
		exe "q!"
	endif
endfunc
nmap ,csd :call Csd() <cr>

"Find this definition
func! Csg()
	let csg = expand("<cword>")
	"new
	exe "cs find g ".csg
	if getline(1) == ""
		exe "q!"
	endif
endfunc
nmap ,csg :call Csg() <cr>

nmap ,cp :cp <cr>   " 이전 태그로 이동
nmap ,cn :cn <cr>   " 다음 태그로 이동

"=============== man page ================
func! Man()
	let sm = expand("<cword>")
	exe "!man -S 2:3:4:5:6:7:8:9:tcl:n:l:p:o ".sm
endfunc

nmap ,m :call Man()<cr><cr>


"========= 주석 매크로 ==========
func! CmtOn()	"주석 on
	exe "'<,'>norm i//"
endfunc

func! CmtOff()	"주석 off
	exe "'<,'>norm 2x"
endfunc

vmap <c-c> <esc>:call CmtOn() <cr>
vmap <c-x> <esc>:call CmtOff() <cr>
nmap <c-c> v:call CmtOn() <cr>
nmap <c-x> v:call CmtOff() <cr>

" number
nmap <F2> <ESC>:set nu! <cr>

nmap <F8> <ESC>O/* IAMROOT23 <C-R>=strftime("%Y%m%d")<CR><CR><SPACE>*<SPACE><CR>*/<ESC><UP><END>a
nmap <F9> <ESC>a/* IAMROOT23 <C-R>=strftime("%Y%m%d")<CR><SPACE>*/<LEFT><ESC>
nmap <F12> <ESC>i__attribute__((optimize("O0")))<CR><ESC>
vmap <F3> :s/[ \t]\+$//


" call plug#begin('~/.vim/plugged')
" 
" " Fcitx5 / IBus ESC 자동 영문 전환 플러그인
" Plug 'rlue/vim-barbaric'
" 
" call plug#end()
