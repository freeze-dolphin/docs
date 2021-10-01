# 桌面环境

*改编自 [NVACG](http://blog.nvacg.org/2019/08/29/freebsd-12-0安装kde5桌面环境nuc5i3ryh/)*

> 本文基于 `Intel NUC5` 构建
>
> 若使用的是其他硬件（特别是显卡、声卡)，则需要安装和配置的步骤可能与本文不同

---

所有指令皆以 `root` 身份执行

## 软件安装

必要的驱动和软件包

| 包名               | 说明                     |
| ------------------ | ------------------------ |
| pam_kde            | KDE                      |
| kde5               | KDE                      |
| xorg               | 桌面服务                 |
| drm-kmod           | `Intel` & `AMD` 显卡驱动 |
| dbus               | 程序通信接口             |
| wqy-fonts          | 中文字体                 |
| sddm               | 会话管理器               |
| xf86-video-intel   | 视频播放硬件解码支持     |
| libva-intel-driver | 视频播放硬件解码支持     |

---

```shell
pkg install -y pam_kde kde5 xorg drm-kmod dbus wqy-fonts sddm xf86-video-intel libva-intel-driver
```

# 显卡驱动

软件包`drm-kmod` 安装后不会默认启用

首先去 [FreeBSD Wiki](https://wiki.freebsd.org/Graphics) 查找你的显卡对应的驱动文件名

比如老式 `AMD` 显卡对应的驱动文件名是 `radeonkms.ko`

---

然后修改 `rc.conf`

``` shell
echo 'kld_list="/boot/modules/显卡对应的驱动文件名"' >> /etc/rc.conf
```

## 音频驱动

修改 `rc.conf` 使声卡驱动随系统启动

```shell
echo 'snd_hda="YES"' >> /etc/rc.conf
```

---

一般台式机需要再执行下面指令

```shell
echo "dev.hdac.0.polling=1" >> /etc/sysctl.conf
echo "hw.snd.default_unit=1" >> /etc/sysctl.conf
```

`hw.snd.default_unit` 值在系统启动时自动设置默认输出端口

一般值为 `0` 时, 音频自机箱后方 `3.5mm` 插孔输出

值为 `1` 时，音频自机箱前方 `3.5mm` 插孔输出

要查看当前系统的默认输出端口, 可以查看 `/etc/sndstat` 文件

另附 [声卡配置文档](https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/sound-setup.html)

*这部分内容有删减, 具体请见 NVACG 原贴*

## KDE 桌面

`KDE` 依赖 `procfs`, 因此需要修改 `fstab` 挂载项

```shell
edit /etc/fstab
```

添加下面这行, 保存并关闭

```fstab
proc /proc procfs rw 0 0
```

---

为了使 `KDE` 支持在普通用户下实现关机、重启功能

需要启用 `dbus` 和 `hald`

```shell
echo 'dbus_enable="YES"' >> /etc/rc.conf
echo 'hald_enable="YES"' >> /etc/rc.conf
```

---

为了使系统启动后自动启动会话管理器 `sddm`, 需要使其随系统启动

```shell
echo 'sddm_enable="YES"' >> /etc/rc.conf
```

## 中文输入

使用指令安装 `fcitx` 即可

```shell
pkg install -y zh-fcitx zh-fcitx-configtool fcitx-qt5 fcitx-m17n zh-fcitx-libpinyin
```

---

为了让 `fcitx` 开机自动启动

将其启动器放入每个使用 `KDE` 的用户的 `KDE` 的启动目录中

```shell
mkdir -p /usr/home/用户名/.config/autostart
cp /usr/local/share/applications/fcitx.desktop /usr/home/用户名/.config/autostart/
```

---

推荐 `fcitx` 皮肤 [Yucklys/fcitx-nord-skin: Nord theme for fcitx (github.com)](https://github.com/Yucklys/fcitx-nord-skin)

预览

![Dark](https://camo.githubusercontent.com/c4467bd20957ebac8736a7c409e7bfcb370e646dfbfbc670860b1bd4232d20ad/68747470733a2f2f692e6c6f6c692e6e65742f323032302f30332f31372f6e48413358717776344e477879644d2e706e67)

![Light](https://camo.githubusercontent.com/f9a5d525b48af13339736661a8987c1f3f6cbf0d7c1161e0d2bf011516438207/68747470733a2f2f692e6c6f6c692e6e65742f323032302f30332f31372f50794b4d7749536d35413670526f552e706e67)

安装方法见仓库 `README`

