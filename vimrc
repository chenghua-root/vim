" map:      映射
" noremap:  no recursive map. map b c, noremap a b, c不会被递归映射为a
" nnoremap: normal模式下的noremap. n, v, i: 普通模式，visual模式，插入模式
" <CR>：    自动回车

" 命令使用说明
" 全局搜索: Grep -r
"**********************************************************

syntax on        " 语法高亮
filetype on      " 文件类型探测

set nocompatible " 不与vi兼容
set ruler
set showmatch
set copyindent
set tabstop=4
set expandtab
set modifiable
set write
set buftype=

set backspace=indent,eol,start
colorscheme default             " /usr/share/vim/vim74/colors/ koehler:peachpuff:ron:slate

set hlsearch                    " 搜索高亮
hi Search ctermbg=DarkBlue
hi Search ctermfg=GREEN         " 搜索字体颜色

hi comment ctermfg=6

let mapleader=','               " default is '\'

nnoremap j gj
nnoremap k gk

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  autocmd! bufwritepost vimrc source $MYVIMRC
endif
if has('mouse')
  set mouse=a
endif

"**********************************************************

" 插件
call plug#begin()
Plug 'scrooloose/nerdtree'              " 目录树
Plug 'skywind3000/asyncrun.vim'         " 异步执行
Plug 'ludovicchabant/vim-gutentags'     " ctags/gtags管理
Plug 'dense-analysis/ale'               " 代码动态检查
Plug 'mhinz/vim-signify'                " 左边栏显示git代码修改状态
Plug 'fatih/vim-go'                     " vim-go插件
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } " LeaderF插件
Plug 'Shougo/echodoc.vim'               " 参数提示
Plug 'tpope/vim-fugitive'               " Git blame/commit/diff

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'

Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'yegappan/grep'
Plug 'chriskempson/base16-vim'

Plug 'roxma/vim-hug-neovim-rpc'         " Shougo/deoplete.nvim依赖
Plug 'roxma/nvim-yarp'                  " Shougo/deoplete.nvim依赖
Plug 'Shougo/deoplete.nvim'             " 补齐提示

call plug#end()


" gtags
" --auto-jump [<TYPE>] 意思是如果只有一个结果直接跳过去
" --by-context ：光标下如果是定义，就跳到引用处，如果是引用，就跳到定义处
let $GTAGSLABEL = 'native-pygments'                  " 6 种语言（C，C++，Java，PHP4，Yacc，汇编）使用native即gtags本地分析器，其它语言使用pygments分析器
let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
set cscopetag                                        " 使用 cscope 作为 tags 命令
set cscopeprg='gtags-cscope'                         " 使用 gtags-cscope 代替 cscope

let s:vim_tags = expand('~/.vim/cache')              " 将自动生成的 tags 文件全部放入 ~/.vim/cache 目录中，避免污染工程目录
if !isdirectory(s:vim_tags)                          " 检测 ~/.vim/cache 不存在就新建
   silent! call mkdir(s:vim_tags, 'p')
endif
set tags=./.tags;,.tags


" gutentags 管理ctags和gtags索引
" 多数功能已被LeaderF代替
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project'] " gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_ctags_tagfile = '.tags'              " 所生成的数据文件的名称
let g:gutentags_cache_dir = s:vim_tags               " gtags 存放路径: ~/.vim/cache/project-absolute-path
let g:gutentags_define_advanced_commands = 1         " 高级特性, :GutentagsToggleTrace打开命令日志, :messages查看日志
let g:gutentags_auto_add_gtags_cscope = 1            " gutentags 自动加载 gtags 数据库

let g:gutentags_modules = []                         " 同时开启 ctags 和 gtags 支持：
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 配置管理 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"let g:gutentags_ctags_extra_args += ['--output-format=e-ctags'] " 如果使用universal ctags需要增加此行，老的Exuberant-ctags不能加此行


" 异步编译asyncrun
let g:asyncrun_open = 20                             " 自动打开 quickfix window ，高度为 6
let g:asyncrun_bell = 1                              " 任务结束时候响铃提醒
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr> " 设置 F10 打开/关闭 Quickfix 窗口


" ALE 代码语法动态检查
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_c_parse_compile_commands = 1

let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta
let g:ale_linters = {
  \   'csh': ['shell'],
  \   'zsh': ['shell'],
  \   'go': ['gofmt', 'golint'],
  \   'python': ['flake8', 'mypy', 'pylint'],
  "\   'c': ['gcc', 'cppcheck'],
  \   'cc': [],
  \   'cpp': ['cppcheck'],
  \   'text': [],
  \}


" git修改比较 vim-signify
set updatetime=100  " updatetime 100ms


" 窗口管理 vim-unimpaired
nmap < [
nmap > ]
omap < [
omap > ]
xmap < [
xmap > ]
set switchbuf=useopen,usetab,newtab


" 参数提示echodoc.vim
" 需配合YCM使用
set cmdheight=2
set noshowmode                          " 关闭模式提示
"let g:echodoc_enable_at_startup = 1
"let g:echodoc#enable_at_startup = 1
"let g:echodoc#type = 'popup'


" 索引跳转Yggdroot/LeaderF
"Leaderf[!]:感叹号表示直接进入normal模式；如果没有感叹号则是输入模式；可以使用tab键进行切换
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30 "显示%30
let g:Lf_CacheDirectory = expand('~/.vim/cache')       "Leaderf gtags 存放路径: ~/.vim/cache/.LfCache/gtags/\_project_absolute_path/
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {
        \ 'File': 0,
        \ 'Buffer': 0,
        \ 'Mru': 0,
        \ 'Tag': 1,
        \ 'BufTag': 1,
        \ 'Function': 0,
        \ 'Line': 1,
        \ 'Colorscheme': 0,
        \ 'Rg': 0,
        \ 'Gtags': 0
        \} "可自动预览的功能项
let g:Lf_PreviewInPopup = 1  "弹窗预览, 使用'p'键即可预览
"map <C-u> <C-Up>   "scroll up in the popup preview window.
"map <C-d> <C-Down> "scroll down in the popup preview window.

noremap <leader>ff :Leaderf file<cr>
noremap <leader>fm :Leaderf! mru --cwd<cr>           "显示最近打开的文件, --cwd:只显示当前项目下最近打开的文件
noremap <leader>fc :Leaderf! function<cr>
noremap <leader>fb :Leaderf! buffer<cr>
noremap <leader>fl :Leaderf! line<cr>
noremap <leader>ft :Leaderf tag<cr>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR> "查找函数/方法定义
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR> "查找函数/方法声明和引用(reference)
noremap <leader>fg :<C-U><C-R>=printf("Leaderf! gtags -g %s --auto-jump", expand("<cword>"))<CR><CR> "查找指定的字符串
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>                         "跳到下一个结果
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>                     "跳到上一个结果
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>                      "重新打开上次的搜索的窗口

noremap <leader>rg :<C-U><C-R>=printf("Leaderf! rg -w -e %s ", expand("<cword>"))<CR><CR>            "search word under cursor, the pattern is treated as regex, and enter normal mode directly
noremap <leader>rn :<C-U><C-R>=printf("Leaderf rg --next %s", "")<CR><CR>                            "跳到下一个结果
noremap <leader>rp :<C-U><C-R>=printf("Leaderf rg --previous %s", "")<CR><CR>                        "跳到上一个结果
noremap <leader>ro :<C-U><C-R>=printf("Leaderf! rg --recall %s", "")<CR><CR>                         "重新打开上次的搜索的窗口
noremap <leader>rt :<C-U><C-R>="Leaderf rg"<CR><CR>

" 代码补全deoplete.nvim
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"   "<TAB>: completion.


"快捷键设置
filetype plugin indent on

set shiftwidth=4
set nu
nnoremap <F2> :NERDTreeToggle<CR>

map <C-j> <C-W>j "切换窗口
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"nmap w, :vertical resize -5<CR> "调整窗口宽度
"nmap w. :vertical resize +5<CR>
"nmap h, :resize -5<CR> "调整窗口高度
"nmap h. :resize +5<CR>

nmap ,v "+p
vmap ,c "+yy
nmap ,c "+yy


"{{{  plugin-格式化代码
"删除所有行未尾空格
nnoremap <f12> :%s/[ \t\r]\+$//g<cr>''

"显示空格
highlight ExtraWhitespace ctermbg=red guibg=red

match ExtraWhitespace /\s\+$/
augroup ExtraWhitespaceGroup
    autocmd!
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
augroup END

set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim
