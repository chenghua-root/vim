## coc配置
coc配置分为用户配置文件和项目配置文件，项目配置文件会合并覆盖用户配置文件

### 用户配置
:CocConfig        // 打开配置文件，一般为~/.vim/coc-settings.json

### 项目配置
:CocLocalConfig   // 打开配置文件，一般为 my-project/.vim/coc-settings.json

## coc help txt
coc帮助文档 ~/.vim/plugged/coc.nvim/doc/coc.txt
:h coc-completion // 可打开coc帮助文档

## coc日志
:CocOpenLog


## coc插件
CocInstall coc-json coc-tsserver coc-clangd coc-rust-analyzer

### 列出安装插件
:CocList extensions
  ?：表示无效插件
 \*：表示插件已激活
  +：表示插件加载成功
  -：表示插件已禁止

### 安装与卸载插件
:CocInstall xxx
:CocUninstall xxx


## C/C++/Object-C插件
coc-clangd(推荐), coc-ccls

### coc-clangd
coc-clangd分析代码时依赖compile_commands.json
参考: https://clangd.llvm.org/installation.html#project-setup

cmake时添加如下编译选项
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1
会在build目录产生compile_commands.json

把build/compile_commands.json链接到项目根目录
ln -s myproject/build/compile_commands.json myproject/

## Rust插件
安装指南：https://blog.csdn.net/m0_37952030/article/details/118372011
:CocInstall coc-rust-analyzer   // 进入rs文件后，会提示是否下载rust-analyzer
