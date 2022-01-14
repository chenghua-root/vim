## Go安装
1. https://golang.org/dl/下载标准包
2. 解压到/usr/local目录sudo tar -xzvf go1.7.5.linux-amd64.tar.gz -C /usr/local
3. 在$HOME目录下创建文件夹gopath
4. 在~/.bashrc添加如下内容，并source  ~/.bashrc
    export GOPATH=$HOME/gopath
    export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

## gopls
An implementation of the Language Server Protocol (LSP ) used by many IDEs.
By using gopls, your text editor automatically gets code auto-completion, analysis, formatting, and more.
With the addition of the vim-go plugin, you’ll have everything you need in Vim.

## vim-go
Does a fantastic job of integrating with gopls and other Go tools to provide an IDE-like experience in Vim

### 安装vim-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " vim-go插件

vim-go安装好后需要通过GoInstallBinaries安装依赖包
由于golang.org, go.dev等网站服务器可能无法直接访问，执行:GoInstallBinaries会失败
需要手动go get安装相关依赖包，依赖包列表vim-go/plugin/go.vim
已存放在go\_install\_binaries.sh中，可直接执行脚本安装
然后执行:
  :GoInstallBinaries
  go clean -cache
  :GoUpdateBinaries

## 其它
go get == go clone + go install

## 参考
Configuring Vim to Develop Go Programs https://medium.com/pragmatic-programmers/configuring-vim-to-develop-go-programs-e839641da4ac
