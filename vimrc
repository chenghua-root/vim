" map:      映射
" noremap:  no recursive map. map b c, noremap a b, c不会被递归映射为a
" nnoremap: normal模式下的noremap. n, v, i: 普通模式，visual模式，插入模式
" <CR>：    自动回车
"
" 命令使用说明
" 全局搜索: Grep -r
"
"**************************************************************************************************


syntax on                 " 语法高亮
filetype plugin indent on " 开启文件类型探测，根据文件类型加载插件(plugin), 定义缩进格式(indent)
let mapleader=','         " default is '\'

let $MYVIMRC = '~/.vimrc'
if has("autocmd")         " 记录文件上次浏览的位置
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  autocmd! bufwritepost vimrc source $MYVIMRC
endif
if has('mouse')           " 支持鼠标，如通过鼠标滚动屏幕
  set mouse=a
endif


"**************************************************************************************************


set nocompatible " 不与vi兼容
set ruler
set copyindent
set tabstop=4    " 设置Tab长度为4空格
set expandtab
set modifiable
set buftype=
set write
set shiftwidth=4 " 设置自动缩进长度为4空格
set nu           " 设置行号
set incsearch    " 开启实时搜索，输入字符后立即自动匹配
"set ignorecase   " 搜索时大小写不敏感

set backspace=indent,eol,start
colorscheme default             " /usr/share/vim/vim74/colors/ koehler:peachpuff:ron:slate

set showmatch                   " 显示括号匹配
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

set hlsearch                    " 搜索高亮
hi Search ctermbg=DarkBlue ctermfg=GREEN

set background=light
hi Comment ctermfg=DarkBlue     " 注释颜色, LightBlue, 246


"**************************************************************************************************


"==============================================================================
" 插件安装，使用VIM-Plug
"==============================================================================
call plug#begin()
Plug 'scrooloose/nerdtree'                         " 目录树
Plug 'skywind3000/asyncrun.vim'                    " 异步执行
Plug 'ludovicchabant/vim-gutentags'                " ctags/gtags管理
Plug 'dense-analysis/ale'                          " 代码动态检查
Plug 'mhinz/vim-signify'                           " 左边栏显示git代码修改状态
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }  " LeaderF插件
Plug 'tpope/vim-fugitive'                          " Git blame/commit/diff
Plug 'jiangmiao/auto-pairs'                        " 自动补全括号的插件，包括小括号，中括号，以及花括号
Plug 'tpope/vim-unimpaired'                        " 窗口管理
Plug 'mhinz/vim-startify'                          " vim启动界面

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'

Plug 'yegappan/grep'                               " Grep -r
Plug 'chriskempson/base16-vim'

Plug 'roxma/vim-hug-neovim-rpc'                    " Shougo/deoplete.nvim依赖
Plug 'roxma/nvim-yarp'                             " Shougo/deoplete.nvim依赖
Plug 'Shougo/deoplete.nvim'                        " 补齐提示
Plug 'Shougo/echodoc.vim'                          " 参数提示

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " vim-go插件
Plug 'dgryski/vim-godef'                           " go 中的代码追踪，输入 gd 就可以自动跳转
call plug#end()


"==============================================================================
" gtags
"==============================================================================
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


"==============================================================================
" gutentags, 用于管理ctags和gtags索引
"==============================================================================
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


"==============================================================================
" asyncrun 异步编译
"==============================================================================
let g:asyncrun_open = 20                             " 自动打开 quickfix window ，高度为 6
let g:asyncrun_bell = 1                              " 任务结束时候响铃提醒
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr> " 设置 F10 打开/关闭 Quickfix 窗口


"==============================================================================
" ALE 代码语法动态检查
"==============================================================================
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


"==============================================================================
" vim-signify，用于git修改比较
"==============================================================================
set updatetime=100  " updatetime 100ms


" 窗口管理 vim-unimpaired
nmap < [
nmap > ]
omap < [
omap > ]
xmap < [
xmap > ]
set switchbuf=useopen,usetab,newtab


"==============================================================================
" echodoc.vim, 用于参数提示
"==============================================================================
" 需配合YCM使用
set cmdheight=2
set noshowmode                          " 关闭模式提示
"let g:echodoc_enable_at_startup = 1
"let g:echodoc#enable_at_startup = 1
"let g:echodoc#type = 'popup'


"==============================================================================
" Yggdroot/LeaderF, 用于索引跳转
"==============================================================================
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
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_WildIgnore={'file':['*.html', '*.txt'],'dir':['3rdparty']}   "忽略文件和目录
let g:Lf_StlColorscheme = 'powerline'
"map <C-u> <C-Up>   "scroll up in the popup preview window.
"map <C-d> <C-Down> "scroll down in the popup preview window.

noremap <leader>f  :Leaderf! self<cr>
noremap <leader>fch :Leaderf! cmdHistory<cr>
noremap <leader>fsh :Leaderf! searchHistory<cr>
noremap <leader>ff :Leaderf  file<cr>
noremap <leader>fm :Leaderf! mru --cwd<cr>           "显示最近打开的文件, --cwd:只显示当前项目下最近打开的文件
noremap <leader>fc :Leaderf! function<cr>
noremap <leader>fb :Leaderf! buffer<cr>
noremap <leader>fl :Leaderf! line<cr>
noremap <leader>ft :Leaderf  tag<cr>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR> "查找函数/方法定义
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR> "查找函数/方法声明和引用(reference)
noremap <leader>fg :<C-U><C-R>=printf("Leaderf! gtags -g %s --auto-jump", expand("<cword>"))<CR><CR> "查找指定的字符串
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>                         "跳到下一个结果
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>                     "跳到上一个结果
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>                      "重新打开上次的搜索的窗口

noremap <leader>rg :<C-U><C-R>=printf("Leaderf! rg -w -e %s --stayOpen", expand("<cword>"))<CR><CR>  "search word under cursor, the pattern is treated as regex, and enter normal mode directly
noremap <leader>rn :<C-U><C-R>=printf("Leaderf rg --next %s", "")<CR><CR>                            "跳到下一个结果
noremap <leader>rp :<C-U><C-R>=printf("Leaderf rg --previous %s", "")<CR><CR>                        "跳到上一个结果
noremap <leader>ro :<C-U><C-R>=printf("Leaderf! rg --recall %s", "")<CR><CR>                         "重新打开上次的搜索的窗口
noremap <leader>rt :<C-U><C-R>="Leaderf rg"<CR><CR>

nmap <unique> <leader>re <Plug>LeaderfRgPrompt
"noremap <leader>re :Leaderf rg -e              -e 正则表达式搜索
nmap <unique> <leader>ra <Plug>LeaderfRgCwordLiteralNoBoundary
"noremap <leader>ra :Leaderf rg -F -e           -F 搜索字符串而不是正则表达式
nmap <unique> <leader>rb <Plug>LeaderfRgCwordLiteralBoundary
"noremap <leader>rb :Leaderf rg -F -w -e        -w 搜索匹配word边界的词
nmap <unique> <leader>rc <Plug>LeaderfRgCwordRegexNoBoundary
"noremap <leader>rc :Leaderf rg -e
nmap <unique> <leader>rd <Plug>LeaderfRgCwordRegexBoundary
"noremap <leader>rd :Leaderf rg -w -e


"==============================================================================
" deoplete.nvim, 用于代码补全
"==============================================================================
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"   "<TAB>: completion.
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })


"==============================================================================
" vim-go
"==============================================================================
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

let g:godef_split=2


"==============================================================================
" NERDTree
"==============================================================================
nnoremap <F2> :NERDTreeToggle<CR> " 打开和关闭NERDTree快捷键


"==============================================================================
" vim-startify
"==============================================================================
let g:startify_padding_left = 100
let g:startify_bookmarks = [
            \ {'v': '~/.vimrc'},
            \ {'b': '~/.bashrc'},
            \ ]


"**************************************************************************************************


"快捷键设置
map <C-j> <C-W>j "切换窗口
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"nmap w, :vertical resize -5<CR> "调整窗口宽度
"nmap w. :vertical resize +5<CR>
"nmap h, :resize -5<CR>          "调整窗口高度
"nmap h. :resize +5<CR>

nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>

nmap ,v "+p
vmap ,c "+yy
nmap ,c "+yy

"nnoremap j gj " 按实际行移动，一行代码换成多个实际行，每次按实际行移动
nnoremap k gk

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


"**************************************************************************************************
"
" Comment
" Constant
" Normal
" NonText
" Special
" Cursor
"
" cterm determines the style, which can be none, underline or bold
" ctermbg and ctermfg are background and foreground colors
"
" **cterm**
"
" bold
" underline
" reverse
" italic
" none

" **cterm-colors**
"
" NR-16   NR-8    COLOR NAME
" 0       0       Black
" 1       4       DarkBlue
" 2       2       DarkGreen
" 3       6       DarkCyan
" 4       1       DarkRed
" 5       5       DarkMagenta
" 6       3       Brown, DarkYellow
" 7       7       LightGray, LightGrey, Gray, Grey
" 8       0*      DarkGray, DarkGrey
" 9       4*      Blue, LightBlue
" 10      2*      Green, LightGreen
" 11      6*      Cyan, LightCyan
" 12      1*      Red, LightRed
" 13      5*      Magenta, LightMagenta
" 14      3*      Yellow, LightYellow
" 15      7*      White
"
"**************************************************************************************************
