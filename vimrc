syntax on        "语法高亮
filetype off     "


"set rtp+=~/.vim/bundle/vundle
"set backspace=indent,eol,start
"call vundle#rc()


set nocompatible "不与vi兼容
set ruler
set showmatch
set copyindent
set tabstop=4
set expandtab

set hlsearch "搜索高亮
hi Search ctermbg=LightYellow "搜索背景色
hi Search ctermfg=GREEN "搜索字体颜色

hi comment ctermfg=6

let mapleader=','  "default is '\'

map j gj
map k gk

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  autocmd! bufwritepost vimrc source $MYVIMRC
endif
if has('mouse')
  set mouse=a
endif

"**********************************************************

set backspace=indent,eol,start


"插件
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'skywind3000/asyncrun.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'dense-analysis/ale'
Plug 'mhinz/vim-signify'
Plug 'fatih/vim-go'
"Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'Shougo/echodoc.vim' "参数提醒
set noshowmode " 关闭模式提示

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'

Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
"Plug 'ycm-core/YouCompleteMe'
Plug 'yegappan/grep'
Plug 'chriskempson/base16-vim'

Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'Shougo/deoplete.nvim'

call plug#end()


"ctags
"call pathogen#helptags()

"gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 tags 文件全部放入 ~/.vim/cache 目录中，避免污染工程目录
let s:vim_tags = expand('~/.vim/cache')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
"let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 检测 ~/.vim/cache 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
set tags=./.tags;,.tags

"gtags
"--auto-jump [<TYPE>] 意思是如果只有一个结果直接跳过去
"--by-context 意思是：光标下如果是定义，就跳到引用处，如果是引用，就跳到定义处
"gtags 存放路径: ~/.vim/cache/project-absolute-path/
let g:gutentags_auto_add_gtags_cscope = 1            " 禁用 gutentags 自动加载 gtags 数据库的行为
let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
let g:gutentags_define_advanced_commands = 1
set cscopetag                                        " 使用 cscope 作为 tags 命令
set cscopeprg='gtags-cscope'                         " 使用 gtags-cscope 代替 cscope


"异步编译asyncrun
let g:asyncrun_open = 20                             " 自动打开 quickfix window ，高度为 6
let g:asyncrun_bell = 1                              " 任务结束时候响铃提醒
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr> " 设置 F10 打开/关闭 Quickfix 窗口


"代码动态检查
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_linters = { 'c++': ['clang'], 'c': ['clang'], 'python': ['pylint'],}


let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta


""-----------------------------------------------------------------------------
"" plugin - ale.vim
""-----------------------------------------------------------------------------
""keep the sign gutter open
"let g:ale_sign_column_always = 1
"let g:ale_sign_error = '>>'
"let g:ale_sign_warning = '--'
"
"" show errors or warnings in my statusline
"let g:airline#extensions#ale#enabled = 1
"
"let g:ale_linters = { 'c++': ['clang'], 'c': ['clang'], 'python': ['pylint'],}
"
"" self-define statusline
""function! LinterStatus() abort
""    let l:counts = ale#statusline#Count(bufnr(''))
""
""    let l:all_errors = l:counts.error + l:counts.style_error
""    let l:all_non_errors = l:counts.total - l:all_errors
""
""    return l:counts.total == 0 ? 'OK' : printf(
""    \  '%dW %dE',
""    \  all_non_errors,
""    \  all_errors
""    \)
""endfunction
""set statusline=%{LinterStatus()}
"
"" echo message
"" %s is the error message itself
"" %linter% is the linter name
"" %severity is the severity type
"" let g:ale_echo_msg_error_str = 'E'
"" let g:ale_echo_msg_warning_str = 'W'
"" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"
"" use quickfix list instead of the loclist
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
"
"" only enable these linters
""let g:ale_linters = {
""\    'javascript': ['eslint']
""\}
"
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-J> <Plug>(ale_next_wrap)
"
"" run lint only on saving a file
"" let g:ale_lint_on_text_changed = 'never'
"" dont run lint on opening a file
"" let g:ale_lint_on_enter = 0
"
""------------------------END ale.vim--------------------------------------


" 修改比较vim-signify
" set signcolumn=yes " 侧边栏一直显示
set updatetime=100  " updatetime 100ms


" 代码高亮highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1  " 高亮成员变量
let g:cpp_class_decl_highlight = 1       " 高亮class声明类名
let g:cpp_posix_standard = 1             " 高亮posix函数
let g:cpp_experimental_simple_template_highlight = 1 " 高亮模板
"let g:cpp_experimental_template_highlight = 1 " 高亮模板
let g:cpp_concepts_highlight = 1         " library concepts
let c_no_curly_error=1


" 窗口管理 vim-unimpaired
nmap < [
nmap > ]
omap < [
omap > ]
xmap < [
xmap > ]
set switchbuf=useopen,usetab,newtab


" 参数提示echodoc.vim
set cmdheight=2
let g:echodoc_enable_at_startup = 1
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'popup'


"代码补全
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone
noremap <c-z> <NOP>
let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }

"Yggdroot/LeaderF
"Leaderf[!]:感叹号表示直接进入normal模式；如果没有感叹号则是输入模式；可以使用tab键进行切换
"Leaderf gtags 存放路径: ~/.vim/cache/.LfCache/gtags/\_project_absolute_path/
let g:Lf_ShortcutF = "<leader>ff"
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30 "显示%30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
let g:Lf_PreviewInPopup = 1

noremap <Leader>fm :Leaderf! mru<cr>           "显示最近打开的文件
noremap <Leader>fc :LeaderfFunction!<cr>
noremap <Leader>fb :LeaderfBuffer<cr>
noremap <Leader>ft :Leaderf! tag --cword<cr>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR> "查找函数/方法定义
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR> "查找函数/方法引用(reference)
noremap <leader>fg :<C-U><C-R>=printf("Leaderf! gtags -g %s --auto-jump", expand("<cword>"))<CR><CR> "查找指定的字符串
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>                      "重新打开上次的搜索的窗口
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>                         "跳到下一个结果
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>                         "跳到上一个结果


" deoplete.nvim
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

nmap w, :vertical resize -5<CR> "调整窗口宽度
nmap w. :vertical resize +5<CR>
nmap h, :resize -5<CR> "调整窗口高度
nmap h. :resize +5<CR>

nmap ,v "+p
vmap ,c "+yy
nmap ,c "+yy


"{{{  plugin-格式化代码
" 删除所有行未尾空格
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

"let g:ycm_seed_identifiers_with_syntax=1    " 语法关键字补全
"let g:ycm_confirm_extra_conf=0  " 打开vim时不再询问是否加载ycm_extra_conf.py配置
"let g:ycm_key_invoke_completion = '<C-a>' " ctrl + a 触发补全
"set completeopt=longest,menu    "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone
let g:ycm_clangd_binary_path = "/disk1/chenghua.ch/download/clang+llvm-9.0.1-powerpc64le-linux-rhel-7.4/bin"

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py'
