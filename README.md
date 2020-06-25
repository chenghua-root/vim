# vim-chenghua

本vim配置参照韦易笑在知乎的回答[如何在Linux下利用Vim搭建C/C++ 开发环境?](https://www.zhihu.com/question/47691414/answer/373700711)

## 环境说明
CentOS7 + VIM8
vimrc配置含义：https://zhuanlan.zhihu.com/p/137722838

## VIM8安装介绍
1. 下载: git clone git@github.com:vim/vim.git
2. 卸载原有VIM：sudo yum remove vim
3. 安装依赖文件:
     sudo yum install -y python-devel python36-devel ruby ruby-devel lua lua-devel perl per-devel perl-ExtUtils-Embed libX11-devel ncurses-devel
4. 编译安装
     ./configure --with-features=huge \
                 --enable-python3interp=yes \
                 --enable-rubyinterp=yes \
                 --enable-luainterp=yes \
                 --enable-perlinterp=yes \
                 --enable-multibyte=yes \
                 --enable-cscope=yes \
                 --prefix=/usr/local/vim
     make
     make install
     ln -s /usr/local/vim/bin/vim /usr/local/bin/vim

说明：a) python3支持。python3自动识别configdif，不需要指定-with-python3-config-dir=xxx
      b) 重新编译之前需要执行make distclean


## 插件管理器
使用vim-plug
安装：
    1. mkdir ~/.vim/autoload
    2. curl -XGET "https://github.com/junegunn/vim-plug/blob/master/plug.vim" ~/.vim/autoload/

## 符号索引ctags
使用universal-ctags
安装：
    1. git clone https://github.com/universal-ctags/ctags.git
    2. Linux参照docs/autotools.rst说明进行安装

## 符号自动索引
使用ludovicchabant/vim-gutentags
安装：
    1. git clone https://github.com/ludovicchabant/vim-gutentags.git ~/.vim/pluged

## 异步运行
安装：Plug 'skywind3000/asyncrun.vim'
使用：
    :AsyncRun cmd

## 代码动态检查
使用：dense-analysis/ale
安装：Plug 'dense-analysis/ale'
使用：待完成


## 修改比较
实时显示与git仓库版本的修改状态
安装：Plug 'mhinz/vim-signify'
使用：
    1. 自动显示在侧边栏
    2. :SignifyDiff 左右分屏对比提交前后记录


## quickfix commands窗口管理
使用vim-unimpaired
安装：
  mkdir -p ~/.vim/pack/tpope/start
  cd ~/.vim/pack/tpope/start
  git clone https://tpope.io/vim/unimpaired.git
  vim -u NONE -c "helptags unimpaired/doc" -c q


## YCM
YCM: https://github.com/ycm-core/YouCompleteMe
YCM安装完全指南: https://github.com/ycm-core/YouCompleteMe/wiki/Full-Installation-Guide
YouCompleteMe中容易忽略的配置: https://zhuanlan.zhihu.com/p/33046090

### 安装依赖
"apt install build-essential cmake vim python3-dev"
build-essential => yum install gcc gcc-c++ make
cmake           => yum install cmake
python3-dev     => yum install python3-devel

