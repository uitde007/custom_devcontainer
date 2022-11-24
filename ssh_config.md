In Windows ssh host config file:
```
Host chronos
  HostName chronos
  User juitdewilligen
  ForwardAgent yes
  ForwardX11 yes
  ForwardX11Trusted yes
  LogLevel DEBUG2
```

In Powershel Windows:
```
setx DISPLAY "127.0.0.1:0.0"
```
direct ssh vanuit PS werkt. Vanuit vcode nog niet.

[](https://github.com/microsoft/vscode-remote-release/issues/4600)

[](https://x410.dev/cookbook/enabling-ssh-x11-forwarding-in-visual-studio-code-for-remote-development/)
