{% import "views/_data.njk" as data %}
{% import "views/_parts.html" as include %}
{% import "views/_helper.njk" as docs %}
# 常见问题一览

## 账户和平台常见问题

### Yliyun_部署在哪个平台操作系统上

Yliyun 部署CenterOS6.5及以上操作系统服务器上，如是windows服务器可通过安装VMware虚拟机，部署一粒云Vm镜像；如需部署在公有云服务器，目前各大云服务平台也都支持Centeros云主机。

{% if node!='qcloud' %}
### 获取客服支持有哪些途径

* 到免费的[用户社区](https://www.yliyun.com/) 进行提问。
* 发送邮件到 {{ include.supportEmail() }} 获取帮助。
* 紧急情况拨打客服电话：0755-33942625。


### 哪里获取平台的更新信息

通常情况下，我们新版本的更新周期为一到两周。获取更新信息可以通过：

* [官方博客](http://www.yliyun.com/blog/)（每次更新的详细信息都会发布在那里）
* 官方微信公众号：一粒云
* 每月初，我们会将每月的更新摘要发送到您的注册邮箱。
* 在控制台页面的右上方有 [消息中心](/info-center.html#/index)，请注意查看新通知。
{% endif %}

### API 开放吗

我们的 API 完全开放。我们提供的 SDK 也都是基于开放 API 实现的。详情请阅读 [REST API 详解](/docs/rest_api.html)。

### 提供哪些平台的 SDK

目前官方提供的 SDK 种类包括：

* Objective-C
* Swift
* Android
* Java
* JavaScript
* Python
* PHP
* Windows Phone
* Unity

部分 SDK 已开源，详情请访问 [SDK 下载](/docs/sdk_down.html) 页面。

### iOS 和 Android 是否可以使用同一个 App

当然可以。使用我们的 SDK，可以为同一个应用开发多个平台的版本，共享后端数据。

### 支持 Unity 3D 吗

支持。请到 [SDK 下载](sdk_down.html) 页面下载 Unity SDK。

### 开发文档有提供搜索功能吗

 **官网文档** 首页右上角就有搜索框，也可以直接访问 [搜索](/search.html) 页面。

## API 相关

### API 调用次数有什么限制吗

开发版提供每天三万次的免费额度。推送服务和统计服务免费使用，并不占用免费额度。

默认情况下，每个应用同一时刻最多可使用的工作线程数为 30，即同一时刻最多可以同时处理 30 个数据请求。**我们会根据应用运行状况以及运维需要调整改值**。如果需要提高这一上限，请写信至 {{ include.supportEmail() }} 进行申请。

### API 调用次数的计算

对于数据存储来说，每次 `create` 和 `update` 一个对象的数据算 1 次请求，如调用 1 次 `object.saveInBackground` 算 1 次 API 请求。在 API 调用失败的情况下，如果是由于 [应用流控超限（错误码 429）](error_code.html#_429) 而被云端拒绝，则**不会**算成 1 次请求；如果是其他原因，例如 [权限不够（错误码 430）](error_code.html#_403)，那么仍会算为 1 次请求。

**一次请求**<br/>
- `create`
- `save`
- `fetch`
- `find`
- `delete`
- `deleteAll`

调用一次 `fetch` 或 `find` 通过 `include` 返回了 100 个关联对象，算 1 次 API 请求。调用一次 `find` 或 `deleteAll` 来查找或删除 500 条记录，只算 1 次 API 请求。

**多次请求**<br/>
- `saveAll`
- `fetchAll`

调用一次 `saveAll` 或 `fetchAll` 来保存或获取 array 里面 100 个 对象，算 100 次 API 请求。

{% if node != 'qcloud' %}
对于 [应用内社交](status_system.html)，`create` 和 `update` 按照 Status 和 Follower/Followee 的对象数量来计费。
{% endif %}

对于 query 则是按照请求数来计费，与结果的大小无关。`query.count` 算 1 次 API 请求。collection fetch 也是按照请求次数来计费。

### 如何获取 API 的访问日志

进入 [控制台 > 存储 > 统计 > API 访问日志](/dashboard/storage.html?appid={{appid}}#/storage/stat/accesslog)，开启日志服务，稍后刷新页面，就可以看到从开启到当前时间产生的日志了。查看

### 可以在线测试 API 吗

请访问 [API 在线测试工具](/dashboard/apionline/index.html)。

### Unauthorized 错误

应用 API 授权失败，请检查是否初始化了 App Id 和 App Key。

* 如何进行初始化，请查看 [SDK 安装指南](start.html)。
* App Id 和 App Key 在应用的 **设置** 菜单里可以找到。

### 错误信息代码和详细解释在哪里

* [错误代码详解](./error_code.html)
* iOS SDK：[AVConstants](/api-docs/iOS/docs/AVConstants.html)
* Android SDK：[AVException](/api-docs/android/index.html)

REST API 返回的错误信息跟 SDK 保持一致。

### 其他语言调用 REST API 如何对参数进行编码

REST API 文档使用 curl 作为示范，其中 `--data-urlencode` 表示要对参数进行 URL encode 编码。如果是 GET 请求，直接将经过 URL encode 的参数通过 `&` 连接起来，放到 URL 的问号后。如 `https://{{host}}/1.1/login?username=xxxx&password=xxxxx`。

### 如何实现大小写不敏感的查询

目前不提供直接支持，可采用正则表达式查询的办法，具体参考 [StackOverflow - MongoDB: Is it possible to make a case-insensitive query](http://stackoverflow.com/questions/1863399/mongodb-is-it-possible-to-make-a-case-insensitive-query)。

使用各平台 SDK 的 AVQuery 对象提供的 `matchesRegex` 方法（Android SDK 用 `whereMatches` 方法）。

### 应用内用户的密码需要加密吗

不需要加密密码，我们的服务端已使用随机生成的 salt，自动对密码做了加密。 如果用户忘记了密码，可以调用 `requestResetPassword` 方法（具体查看 SDK 的 AVUser 用法），向用户注册的邮箱发送邮件，用户以此可自行重设密码。 在整个过程中，密码都不会有明文保存的问题，密码也不会在客户端保存，只是会保存 sessionToken 来标示用户的登录状态。

### 查询结果默认最多只能返回 1000 条数据，当我需要的数据量超过了 1000 该怎么办？
可以通过每次变更查询条件，来继续从上一次的断点获取新的结果，譬如：
* 第一次查询，createdAt 时间在 2015-12-01 00:00:00 之后的 1000 条数据（最后一条的 createdAt 值是 x）；
* 第二次查询，createdAt 在 x 之后的 1000 条数据（最后一条的 createdAt 是 y）；
* 第三次查询，createdAt 在 y 之后的 1000 条数据（最后一条是 z）；

以此类推。

{{ data.innerQueryLimitation(heading="### 使用 CQL 子查询时查不到记录或查到的记录不全") }}

### 当数据量越来越来大时，怎么加快查询速度？
与使用传统的数据库一样，查询优化主要靠索引实现。索引就像字典里的目录，能帮助你在海量的文字中更快速地查词。目前索引提供 3 种排序方案：正序、倒序和 2dsphere。

前面两种很好理解，就是按大小或者英文字母的顺序来排列。场景比如，你的某一张表记录着许多商品，其中一个字段是商品价格。以该字段建好索引后，可以加快在查询时，相对应的正序或者倒序数据的返回速度。第三种，是适用于地理位置经纬度的数据（控制台上的 GeoPoint 型字段）。移动场景中的常见需求都可能会用到地理位置，比如查找附近的其他用户。这时候就可以利用 2dsphere 来加快查询。

原则：数据量少时，不建索引。多的时候请记住，因为索引也占空间，以此来换取更少的查询时间。针对每张表的情况，写少读多就多建索引，写多读少就少建索引。

操作：进入 {% if node=='qcloud' %}**控制台 > 存储**{% else %}[控制台 > 存储](/data.html?appid={{appid}}#/_File){% endif %}，选定一张表之后，点击右侧的 **其他**下拉菜单，然后选择 **索引**，然后根据你的查询需要建立好索引。

提示：数据表的默认四个字段 `objectId`、`ACL`、`createdAt`、`updatedAt` 是自带索引的，但是在勾选时，可以作为联合索引来使用。

{{
  docs.note(
    data.limitationsOnCreatingClassIndex()
  )
}}


### sessionToken 在什么情况下会失效？
如果在控制台的存储的设置中勾选了「密码修改后，强制客户端重新登录」，则用户修改密码后， sessionToken 会变更，需要重新登录。如果没有勾选这个选项，Token 就不会改变。当新建应用时，这个选项默认是被勾上的。

### 默认值的查询结果为什么不对

这是默认值的限制。MongoDB 本身是不支持默认值，我们提供的默认值只是应用层面的增强，对于老数据只是在查询后做了展现层的优化。有两种解决方案：

1. 对老的数据做一次更新，查询出 key 不存在（whereDoesNotExist）的记录，再更新回去。
2. 查询条件加上 or 查询，or key 不存在（whereDoesNotExist）。

### User 表中有 authData 数据，但是当前登录用户无法获取 authData 数据

{{ include.retrieveAuthData(node) }}

## 控制台相关

### 如何导入或者导出数据？

请参考《数据与安全》文档的 [导入数据](./dashboard_guide.html#本地数据导入_LeanCloud) 和 [导出数据](./dashboard_guide.html#云端数据导出到本地) 部分。


### 创建唯一索引失败

请确认想要创建索引的列没有已经存在的重复值。

### 如何上传文件

任何一个 Class 如果有 File 类型的列，就可以直接在 **数据** 管理平台中将文件上传到该列。如果没有，请自行创建列，类型指定为 File。

## iOS/macOS SDK

### 安装 Cocopods 失败怎么解决

推荐使用淘宝提供的 Gem 源，访问 [https://ruby.taobao.org/](https://ruby.taobao.org/)。

```sh
$ gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/
$ gem sources -l
*** CURRENT SOURCES ***

https://ruby.taobao.org
# 请确保只有 ruby.taobao.org
$ gem install cocoapods
```

由于淘宝已经停止基于 HTTP 协议的镜像服务，如果之前使用的是 [http://ruby.taobao.org/](http://ruby.taobao.org/)，这也可能导致安装 Cocopods 失败。

需要在配置中使用 HTTPS 协议代替：

```sh
$ gem sources --add https://ruby.taobao.org/ --remove http://ruby.taobao.org/
$ gem sources -l
*** CURRENT SOURCES ***

https://ruby.taobao.org
# 请确保只有 ruby.taobao.org
$ gem install cocoapods
```


### 编译失败

#### Symbol(s) not found x86_64

请使用 32 位模拟器进行编译和调试.


### 请求报错

请参考请求返回的错误码 [详细说明](error_code.html)。

### 地理位置查询错误

如果错误信息类似于 `can't find any special indices: 2d (needs index), 2dsphere (needs index), for 字段名`，就代表用于查询的字段没有建立 2D 索引，可以在 Class 管理的 **其他** 菜单里找到 **索引** 管理，点击进入，找到字段名称，选择并创建「2dsphere」索引类型。

![image](images/geopoint_faq.png)

### 如何先验证手机号码再注册

请参考 [存储开发指南 &middot; 手机号码登录](leanstorage_guide-objc.html#手机号码登录")。


## Android SDK

### 对 AVObject 对象使用 getDate("createdAt") 方法读取创建时间为什么会返回 null

请用 `AVObject` 的 `getCreatedAt` 方法；获取 `updatedAt` 用 `getUpdatedAt`。

### client.open() 操作为什么没有被调用？

请检查 AndroidManifest.xml 配置，确认 receiver 和 service 写在了 application 标签里，并且与 activity 平级。它们与 activity 同为四大组件之一，需要写在一起。


### 如何先验证手机号码再注册

请参考 [存储开发指南 &middot; 手机号码登录](leanstorage_guide-android.html#手机号码登录")。

## JavaScript SDK

### 有没有同步 API

JavaScript SDK 由于平台的特殊性（运行在单线程运行的浏览器或者 Node.js 环境中），不提供同步 API，所有需要网络交互的 API 都需要以 callback 的形式调用。我们提供了 [Promise 模式](leanstorage_guide-js.html#Promise) 来减少 callback 嵌套过多的问题。

### 在 AV.init 中用了 Master Key，但发出去的 AJAX 请求返回 206
目前 JavaScript SDK 在浏览器（而不是 Node）中工作时，是不会发送 Master Key 的，因为我们不鼓励在浏览器中使用 Master Key，Master Key 代表着对数据的最高权限，只应当在后端程序中使用。

如果你的应用的确是内部应用（做好了相关的安全措施，外部访问不到），可以在 `AV.init`之后增加下面的代码来让 JavaScript SDK 发送 Master Key：
```
AV.Cloud.useMasterKey(true);
```

### 如何先验证手机号码再注册

请参考 [存储开发指南 &middot; 手机号码登录](leanstorage_guide-js.html#手机号码登录")。


## 消息推送

### 推送的到达率如何

关于到达率这个概念，业界并没没有统一的标准。我们测试过，在线用户消息的到达率基本达到 100%。我们的 SDK 做了心跳和重连等功能，尽量维持对推送服务器的长连接存活，提升消息到达用户手机的实时性和可靠性。

### 推送是基于 XMPP 还是其他协议

老版本推送基于 XMPP 协议，v2.4.1 版本开始，推送采用了 WebSocket 协议，方便支持多平台，包括将要推出的 Web 端消息推送功能。

### iOS 推送如何区分开发证书和生产证书

暂不提供在同一个 App 里同时上传开发证书和生产证书。推荐创建单独的测试 App，可以利用数据导出和导入来快速模拟生产环境。

### 有一些 iOS 设备收不到推送，到控制台查看推送记录，发现 invalidTokens的 数量大于0，是怎么回事？

invalidTokens 的数量由以下两部分组成：
* 选择的设备与选择的证书不匹配时，会增加 invalidTokens 的数量，例如使用开发证书给生产证书的设备推送。
* 目标设备移除或重装了对应的 App。

针对第一种情况，请检查 APNS 证书是否过期，并检查是否使用了正确的证书类型。

更多推送问题排查，请参考：
[推送问题排查](push_guide.html#推送问题排查)。


## 统计

### 统计服务免费吗

统计服务完全免费，不占用每月的 API 免费额度。

### 统计服务支持哪些平台

目前支持

* iOS
* macOS
* Android

更多平台 SDK 正在开发中。

### 统计支持哪些发送策略

* 启动时发送（默认策略，推荐使用）
* 批量发送
* 按最小间隔发送

可以在 **分析** > **Android（或者 iOS）统计** > **统计设置** > **数据发送策略** 的菜单里实时修改这些策略。

## 文件

### 文件存储有 CDN 加速吗？

{{ data.cdn() }}

### 文件存储有大小限制吗？

没有。除了在浏览器里通过 JavaScript SDK 上传文件，或者通过我们网站直接上传文件，有 10 MB 的大小限制之外，其他 SDK 都没有限制。 JavaScript SDK 在 Node.js 环境中也没有大小限制。

