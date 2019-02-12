{% import "views/_helper.njk" as docs %}
{% import "views/_parts.html" as include %}
# Server 安装指南

## 服务器要求

### 服务器硬件要求

* 硬盘：20G以上（最低10G）
* 内存：2G以上（最低1G）

### 服务器软件要求

* 操作系统：64位CentOS 6，推荐使用CentOS 6.5 ~ 6.8
* 下载地址：http://45.199.187.116/downloads/tools/CentOS-6.8-x86_64-minimal.iso

## 自动安装

通过获取一粒云自动化安装脚本一键安装。

首先，登录服务器设备：

* 1、接入显示器、输入设备，通过用户名密码登录服务器
     或者使用xshell等连接工具，远程连接登入服务器

* 2、获取在线安装脚本 
```sh
   wget http://app.yliyun.com/download/v4.2.2-install.sh
```

* 3、授权并执行安装脚本
```sh
   chmod +x v4.2.2-install.sh
   ./v4.2.2-install.sh
```

执行成功后，等待系统安装完成，视网络速度预计20分钟左右。


## 手动安装

### 下载安装包

首先下载 [一粒云最新版完整包](http://app.yliyun.com/download/yliyun-v4.2.2-2018001025.tar.gz)：


然后通过SFTP等工具将安装包上传到服务器(这里服务器地址为：192.168.0.12)：

```sh
scp yliyun-xxx-buildxxxx.tar.gz --tags root@192.168.0.12:/home
```

### 解压安装包

```sh
tar xvf yliyun-xxx-buildxxxx.tar.gz
```

#### 开始安装

进入yliyun目录，执行安装程序
```sh
     cd yliyun
     ./setup
```


## 启动服务

执行一粒云服务器启动命令

```sh
/opt/yliyun/bin/yliyun start
```

此时服务器启动完成，如无异常，打开浏览器访问服务器地址“192.168.0.12”。即可打开一粒云登录界面：
<img src="images/login.jpeg" class="img-responsive" alt="">






