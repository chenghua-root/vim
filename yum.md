## 常用命令
yum install         #后面跟软件包，是安装相关软件
yum remove          #后面跟软件，是卸载相关软件
yum update          #后面跟软件，是升级相关软件
yum search          #后面跟软件，是搜索已安装的软件
yum info            #后面跟软件，是查看软件的额外信息
yum list            #列出可安装的软件包，如果后面跟软件名称，就是列出此软件的状态
yum list installed  #列出已经安装的软件包
yum provides \*/    #斜杠/后面跟命令，可以查看命令属于哪个软件包
yum grouplist       #列出可安装的软件包组
yum groupinsall     #后面跟软件包组的名称么就是安装软件包组里面的软件
yum deplist         #后面跟软件，查看此软件的依赖情况


## 回滚
1. 查看yum history, 获取yum命令历史执行ID
2. yum history undo ID
