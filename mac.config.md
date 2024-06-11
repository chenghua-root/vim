## ssh config
文件名 ~/.ssh/config

```
Host *
    Host devhost
    HostName 127.0.0.1
    User user_name
    Port 22
    ProxyCommand ssh -qW %h:%p jump-box

Host *
    GSSAPIAuthentication yes
    GSSAPIDelegateCredentials no
    ForwardAgent yes
    ServerAliveInterval 60
    ServerAliveCountMax 3
    TCPKeepAlive yes
    ControlMaster auto
    ControlPath ~/.ssh/%h-%p-%r
    ControlPersist 4h
    Compression yes
```

## 更新ssh
brew install openssh

$ ssh -V
OpenSSH_9.7p1, OpenSSL 3.3.0 9 Apr 2024

