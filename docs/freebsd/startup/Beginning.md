# 万物伊始

## 安装时

个人电脑安装时选用 `UFS` 即可, 无需使用 `ZFS`

## 安装完成后

进入 `Shell` 来完成一些手动的设置 (在安装完成的提示框里选 `Yes`)

此时以 `root` 身份登录

使用 `edit` 指令进行文本文件的编辑


### 先设定国内镜像源

修改 `pkg` 源

```shell
mkdir -p /usr/local/etc/pkg/repos
vim /usr/local/etc/pkg/repos/FreeBSD.conf

# content of FreeBSD.conf
FreeBSD: {
    url: "pkg+http://mirrors.ustc.edu.cn/freebsd-pkg/${ABI}/quarterly",
}
```

修改 `ports` 源

```shell
vim /etc/make.conf

# content of make.conf
FETCH_CMD=axel -n 10 -a
DISABLE_SIZE=yes
MASTER_SITE_OVERRIDE?=http://mirrors.ustc.edu.cn/freebsd-ports/distfiles/${DIST_SUBDIR}/
```

修改 `portsnap` 源

```shell
vim /etc/portsnap.conf

# content of porsnap.conf
SERVERNAME=mirror.bjtu.edu.cn/reverse/freebsd-portsnap/
```

