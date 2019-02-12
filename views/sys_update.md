{% import "views/_helper.njk" as docs %}

# 系统手动升级和安装说明

使用最新版本系统的用户通常可以通过在线升级的方式来获取系统的新版本。部分有定制功能的客户，或需要技术服务的企业客户有升级需求时，可参考此文档手动升级。


## 操作步骤（以4.2升级包更新为例）：

> 1.停止一粒云服务

```
/opt/yliyun/bin/yliyun stop
```

> 2.下载4.2更新包到opt目录,各个版本的安装包及更新包，请前往 [下载中心](sdk_down.html)下载


> 3.解压更新包，用解压包下的yliyun目录覆盖/opt下的yliyun目录

```
把install.sh文件移动到/opt目录下

unzip update-4.2
\cp -rf /opt/update-4.2/4.2.0/yliyun /opt
cp /opt/update-4.2/4.2.0/install.sh  /opt

```
> 4.启动mysql服务

```
/opt/yliyun/bin/mysqld start
```
> 5.连接数据库，按顺序执行数据库更新脚本

```
/opt/yliyun/mysql/bin/mysql -uroot -p
密码：*******
mysql> source /opt/update-4.2/4.2.0/sql/4.1.0.sql
mysql> source /opt/update-4.2/4.2.0/sql/4.2.0.sql
mysql> quit  #退出
```


> 6.启动一粒云服务
```
/opt/yliyun/bin/yliyun start
```

> 7.升级完成，清除浏览器缓存访问。
