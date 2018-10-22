{% import "views/_helper.njk" as docs %}
{% import "views/_parts.html" as include %}
# Server 安装指南

## 服务器要求

### 服务器硬件要求

* 硬盘：20G以上（最低10G）
* 内存：2G以上（最低1G）

### 服务器软件要求

* 操作系统：64位CentOS 6，推荐使用CentOS 6.5 ~ 6.8
* 下载地址：http://ftp.sjtu.edu.cn/centos/6.8/isos/x8664/CentOS-6.8-x8664-minimal.iso

## 自动安装

通过获取一粒云自动化安装脚本一键安装。

首先，登录服务器设备：

* 1、接入显示器、输入设备，通过用户名密码登录服务器
     或者使用xshell等连接工具，远程连接登入服务器

* 2、获取在线安装脚本 
```sh
   wget http://app.yliyun.com/install.sh
```

* 3、授权并执行安装脚本
```sh
   chmod 755 install.sh
   ./install.sh
```

执行成功后，等待系统安装完成。


## 手动安装

### 下载安装包

首先下载 [一粒云最新版完整包](http://app.yliyun.com/dowload/yliyun-4.2.1-build2018101014.tar.gz)：


然后通过SFTP等工具将安装包上传到服务器(这里服务器地址为：192.168.0.12)：

```sh
scp yliyun-4.2.1-build2018101014.tar.gz --tags root@192.168.0.12:/home
```

### 解压安装包

```sh
tar xvf yliyun-4.2.1-build2018101014.tar.gz
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


## 查看服务器错误

某个请求出错，SDK 会返回对应的错误信息。错误信息格式如下：
 
- **error.code**：错误码，详见 [文档](error_code.html)。
- **error.domain**：错误域名，只有当 `error.domain` = `kLeanCloudErrorDomain` 时，才是 LeanCloud 返回的错误。
- **error.localizedFailureReason**：错误信息详情
- **error.userInfo**：其他信息，如历史版本的兼容信息等。

例如 示例代码如下：

```objc
AVUser *user = [AVUser user];
user.username = @"Tom";
user.password =  @"cat!@#123";
[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

   // 获取 RESTAPI 返回的错误信息详情（SDK 11.0.0 及以上的版本适用）
    if ([error.domain isEqualToString:kLeanCloudErrorDomain] && error.code == 202) {
    
    	NSString *errorMessage = error.localizedFailureReason;
    	if (errorMessage) {
        // handle error message
    }
}
}];
```
