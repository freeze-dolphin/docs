# TTY 生活

## Softwares

- 爲了在 tty 中顯示非英文字符, 需要安裝 `fbterm`
  
  注意部分發行版 (或者過新的操作系統) 可能不支持此軟件

  安裝系統之前請仔細檢查

  ```shell
  sudo apt install fbterm
  ```

- 真正的操作系統: emacs
  
  編譯安裝參考: https://ubuntuhandbook.org/index.php/2021/12/compile-gnu-emacs-source-ubuntu/

  記得裝上自己的 spacemacs 配置文件

  有關 spacemacs 的問題, 參考: https://liuzhijun-source.github.io/spacemacs-14-days/#/

## Problems

1. 將 fbterm 設爲自動啓動

   有些發行版可能沒有自帶 `rungetty`

   先嘗試安裝

   ```shell
   sudo apt install rungetty
   ```

   修改 `/etc/systemd/system/getty.target.wants/getty@tty1.service`

   修改 `[Service]` 配置段中的 `ExecStart` 配置項爲
   
   ```
   -/sbin/rungetty -u root tty1 -- fbterm -- login
   ```

<details>

- 自定義 fbterm, 參考: https://gist.github.com/zellio/5809852

- Ubuntu Server 開機卡在等待 networking, 參考: https://askubuntu.com/questions/972215/a-start-job-is-running-for-wait-for-network-to-be-configured-ubuntu-server-17-1

- 將 fbterm 設定爲自動啓動, 參考: https://qastack.jp/superuser/438950/how-do-i-make-ubuntu-start-fbterm-in-the-tty-on-startup

</details>