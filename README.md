# vim-chenghua


本vim配置参照韦易笑在知乎的回答[如何在Linux下利用Vim搭建C/C++ 开发环境?](https://www.zhihu.com/question/47691414/answer/373700711)

## 环境说明
CentOS7 | ubuntu20.04 | debain10 + VIM9(安装时依赖python3)
vimrc配置含义：https://zhuanlan.zhihu.com/p/137722838


## python3
参考：https://www.liquidweb.com/kb/how-to-install-python-3-on-centos-7/
2. yum install -y python3
3. ll /usr/bin/python\*
4. sudo rm /usr/bin/python
5. sudo ln -s /usr/bin/python3.6 /usr/bin/python
6. 安装完VIM8后可以换回python2

## VIM9安装(ubuntu)
参考 https://itsfoss.com/install-latest-vim-ubuntu/
- sudo add-apt-repository ppa:jonathonf/vim
- sudo apt update
- sudo apt install vim
- vim --version

## VIM9源码安装(centos/debain)
1. 下载: git clone git@github.com:vim/vim.git
2. 卸载原有VIM：sudo yum remove vim
3. 安装依赖文件:
     sudo yum install -y python-devel python36-devel ruby ruby-devel lua lua-devel perl perl-devel perl-ExtUtils-Embed libX11-devel ncurses-devel
4. 编译安装
     ./configure --with-features=huge \
                 --enable-python3interp=yes \
                 --enable-rubyinterp=yes \
                 --enable-luainterp=yes \
                 --enable-perlinterp=yes \
                 --enable-multibyte=yes \
                 --enable-cscope=yes \
                 --prefix=/usr/local/vim
     make -j4
     sudo make install
     sudo ln -s /usr/local/vim/bin/vim /usr/local/bin/vim
5. :echo has('python3') 预期返回1

说明：a) python3支持。python3自动识别configdif，不需要指定-with-python3-config-dir=xxx
      b) 重新编译之前需要执行make distclean


## 插件管理器
使用vim-plug
安装：
    1. mkdir -p ~/.vim/autoload
    2. cp plug.vim ~/.vim/autoload/plug.vim
       或者curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
修改vimrc后执行:source %
运行:PlugInstall or PlugClean


## 符号索引ctags
使用universal-ctags
安装：
    1. 本仓库已有
       或者git clone https://github.com/universal-ctags/ctags.git
    2. Linux参照docs/autotools.rst说明进行安装
       ./autogen.sh
       ./configure --prefix=/usr/local/bin
       make
       sudo make install
    3. kind说明：http://ctags.sourceforge.net/FORMAT
       c: class name
       m: member
       f: function or method name #实现
       F: file name
       p: function prototype #声明
       s: struct name
       t: typedef
       u: union name
       x: 前置声明


## 符号自动索引
使用ludovicchabant/vim-gutentags
安装：
    1. Plug 'ludovicchabant/vim-gutentags'
       或者git clone https://github.com/ludovicchabant/vim-gutentags.git ~/.vim/plugged/vim-gutentags
    2. pip install pygments


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


## gtags
使用指南：https://zhuanlan.zhihu.com/p/36279445
使用指南：https://blog.csdn.net/weixin_33816821/article/details/91372655
使用指南：https://zhuanlan.zhihu.com/p/64842373
下载安装：http://tamacom.com/global/global-6.6.5.tar.gz
或者sudo apt-get install global

### 配置gtags.conf
从global-6.6.5或其它机器拷贝配置文件
sudo cp gtags.conf /usr/local/share/gtags/gtags.conf


## Leaderf
sudo apt-get install ripgrep


## deoplete.nvim
安装指南：https://github.com/Shougo/deoplete.nvim
Requirements：
  1.sudo pip3 install pynvim


## coc.nvim
参考CocReadme.md
