{% import "views/_helper.njk" as docs %}

# 钉钉集成

## 钉钉配置

1、一粒云管理后台配置步骤：

* 以管理员账号登录云盘-点击头像-选择【后台管理】-进入管理后台页面

* 选择【插件中心】-"钉钉插件"配置钉钉参数，如下图：

<img src="images/dd-1.jpeg" class="img-responsive" alt="">

2、钉钉管理后台配置步骤：

### 1、创建微应用

* 企业管理员帐号登入[钉钉管理后台](https://oa.dingtalk.com)， -> 【工作台】-> 下方的【自建应用】

<img src="images/dd-2.jpeg" class="img-responsive" alt="">


> 首页地址 必须填写云盘访问地址+ 指定vaildation.html 页面 如：http://21t37744b5.51mypc.cn/vaildation.html （域名和ip都行）

<img src="images/dd-3.jpeg" class="img-responsive" alt="">

> 提交后得到对应的CorpSecret  ⑤和agentId  ⑥

### 2、配置开发选项

* 如下图点击【应用开发】跳转到钉钉开放平台：

<img src="images/dd-4.jpeg" class="img-responsive" alt="">

### 3、扫码登录授权

* 进入钉钉开放平台-> 应用开发-> 移动接入应用，点击【创建扫码登录应用授权】

> 授权LOGO地址 必须为外网地址，供钉钉访问 。例如：http://www.yliyun.com/dlogo.png

<img src="images/dd-5.jpeg" class="img-responsive" alt="">

> 回调域名设置为云盘访问主页 如：http://21t37744b5.51mypc.cn/login.html

<img src="images/dd-6.jpeg" class="img-responsive" alt="">

### 4、获取对接字段

* 创建成功后获得 appId 、appSecret和登录回调如下图对应的① 、② 、⑦


### 5、对接字段查看

* 点击开发信息-> 开发账号管理。企业接口调用查看到，corpId和corpSecret获得下图 
    
<img src="images/dd-7.jpeg" class="img-responsive" alt="">

> 点击新增授权弹出授权窗口，填写正确的数据

<img src="images/dd-8.jpeg" class="img-responsive" alt="">

<img src="images/dd-9.jpeg" class="img-responsive" alt="">


3、配置完成，在企业组织架构可看到同步完成的钉钉组织架构信息。

<img src="images/dd-10.jpeg" class="img-responsive" alt="">


```
注意事项：
如果提示配置信息错误，请确认输入的各项信息是否正确，一定要确认各项信息是正确的。
如果提示配置成功，到部门成员设置那里，查看钉钉用户是否同步进来，扫码登录是否正常。
钉钉账号未同步进来，请确认你的授权总用户数是否大于你集成的钉钉用户数，如果小于是同步不进来的，授权用户数必须大于你集成进来的钉钉用户数。
```

## 钉钉帐号使用指南

1、web浏览器登录

如配置无误，打开企业云盘登录界面，可看到钉钉帐号登录模块

<img src="images/dd-11.jpeg" class="img-responsive" alt="">

> 1. 打开钉钉手机app，扫码登录
2. 使用钉钉帐号密码登录


2、Mac或windows客户端登录，同浏览器相似（需要注意的是：云盘服务器地址要与钉钉配置的服务器地址一致）

3、手机APP登录

>1. 可打开一粒云APP，使用钉钉帐号密码登录
1. 打开钉钉APP，选择企业微应用-点击【云盘微应用】免登打开手机一粒云APP，如未安装，则会提示先安装云盘APP。

 详细电子文档下载：[钉钉集成.docx](http://45.199.187.116/downloads/docs/%e9%92%89%e9%92%89%e9%9b%86%e6%88%90.docx)
