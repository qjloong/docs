{% import "views/_helper.njk" as docs %}

# 手动扩容和更改存储路径

> 查看目前硬盘大小以及分区情况

```
df -hl
lsblk            # 查询以识别的硬件和分区
```

> 开始分区

```
fdisk /dev/vdb        #进入需要分区的盘
p                #查看分区情况
n                 #添加分区
p                #创建主分区    e    #创建扩展分区
1                #分区编号
开始位置    回车默认
结束位置    回车默认
p                 #查看分区情况
w                #保存退出
lsblk            # 查询以识别的硬件和分区
```


根据需要重启系统，这里不用重启
（挂载外部磁盘，不用重启系统。磁盘扩容情况的，需要重启系统，否则无法格式化新建的分区）

```
mkfs.ext4 /dev/vdb1   #格式化分区
mkdir /fdfs            #新建挂载点为fdfs目录
mount /dev/vdb1 /fdfs      #新加磁盘挂载到f dfs
vi /etc/fstab                        #添加配置，开机自动挂载
```

> 保存退出。重启系统

<img src="images/raid/ext1.jpeg" class="img-responsive" alt="">

```
df -hl        #查看磁盘挂载情况
```

> 调整一粒云存储路径

```
vi /opt/yliyun/fdfs/etc/storage.conf
vi /opt/yliyun/fdfs/etc/mod_fastdfs.conf
更改路径 ：store_path0=  xxxxxx
```

增加一粒云存储路径

```
vi /opt/yliyun/fdfs/etc/storage.conf
vi /opt/yliyun/fdfs/etc/mod_fastdfs.conf
```

<img src="images/raid/ext2.jpeg" class="img-responsive" alt="">


```
vi /opt/yliyun/fdfs/etc/tracker.conf
  更改store_server=2
          store_path=2           # 根据增加的路径数量更改数值
```
         
<img src="images/raid/ext3.jpeg" class="img-responsive" alt="">
          
```
#vi /opt/yliyun/openresty/nginx/conf/nginx.conf
```
如果出现以下提示 则需要删除缓存文件

<img src="images/raid/ext4.jpeg" class="img-responsive" alt="">

```
#rm -rf /opt/yliyun/openresty/nginx/conf/.nginx.conf.swp
```
找到所有 set $M00 的位置 【如果配置文件内 没有找到  set $M00  此类字符串，则跳过该步骤！！！】

重启服务

```
/opt/yliyun/bin/fdfs stop
/opt/yliyun/bin/fdfs start
/opt/yliyun/bin/nginx restart
```

若为更改存储路径 ，则需要执行如下步骤，否则以前上传的文件将不能下载

```
#\cp -rf /opt/yliyun/data/g1_data0/*   /fdfs/g1_data0/
```

注意cp 前面的斜杠
根据已上传文件数量的多少，可能执行时间会比较长
复制完成后 原来上传的文件就能下载了。

最后删除旧文件，如果空间足够，且没有把握存储是否生效的话，不删除旧文件也不会对系统运行产生影响
```
# rm -rf /opt/yliyun/data/g1_data0
```
