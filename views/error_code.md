{% import "views/_im.njk" as im %}
# 错误码详解

本文档列举出服务端返回的错误码及相应说明。详细错误码，请参考以下链接：


## 400

* 信息 - `Bad Request`
* 含义 - 服务未开启或启动失败。
* 模块 - 服务部署

## 404
* 信息 - `404 Not Found.`
* 含义 - 未输入正确的服务器地址，或后台服务未开启。

## err_net

* 信息 - `The connection to the servers failed.`
* 含义 - 无法建立 TCP 连接到服务器，通常是因为网络故障，或者我们服务器故障引起的。

## err_500

* 信息 - `unkown error.`
* 含义 - 请求参数错误或非法的请求操作

## err_not_conform_to_login_rules

* 信息 - `err_not_conform_to_login_rules.`
* 含义 - 帐号登录受限，管理员设置服务端安全策略，导致用户登录受限。

## err_user_notexist

* 信息 - `err_user_notexist`
* 含义 - 用户名不存在，检查用户名拼写是否正确。

## err_user_locked

* 信息 - `err_user_locked`
* 含义 - 用户名及密码多次输入错误后，即会锁定用户帐号，需要系统管理员解锁后才可继续使用。


## 401

* 信息 - `Unauthorized.`
* 含义 - 未经授权的访问。

## 403

服务访问授权已过期，或是 User 缺失了 token 信息等情况下，云端会统一地返回 403 错误码及不同的错误信息，代表当前请求因权限不够而被拒。例如：

- 信息 - `Forbidden to read/write by class permissions`
- 含义 - 操作被禁止，文件访问操作授权已超时，需要重新获取权限才可继续使用。



<!--{{ im.errorCodes() }}-->

