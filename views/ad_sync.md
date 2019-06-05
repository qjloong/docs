{% import "views/_helper.njk" as docs %}

# 备份同步

## 云端同步

同步功能是将云盘文件添加到本地目录，也可以将本地文件添加到云盘，实现双向同步备份。

* 1、登录云盘windows客户端，点击右下角的文件传输-选择文件同步；
* 2、开启同步按钮-直到同步任务提示已完成。

<img src="images/sync-1.jpeg" class="img-responsive" alt="">

<img src="images/sync-2.jpeg" class="img-responsive" alt="">


双击打开我的电脑-默认本地盘符新增个人盘符、同步盘符的快速入口。

<img src="images/sync-3.jpeg" class="img-responsive" alt="">

>注意事项：
1. 目前同步只能同步到个人空间，暂时不支持同步到群组和共享空
2. 开启同步按钮后，默认只同步个人根目录的文件不同步文件夹，
3. 开启同步按钮将实时监控文件，关闭同步，则不支持实时监控。
4. 如果数据未同步，请确认云盘安装是否在英文目录下（选择默认安装即可），本地文件后缀名是否显示。
5. 本地同步数据到云盘提示空间不够，请增加空间


## 云端备份

备份本地文件到云端，同样文件不会重复备份


* 1、登录云盘windows客户端，点击右下角的文件传输-选择云盘备份
* 2、新建任务，选择本地要备份的目录-再选择云盘备份的路径（目录），接下来选择定时任务还是手动任务，点击提交任务即可完成备份任务操作。

<img src="images/sync-4.jpeg" class="img-responsive" alt="">

<img src="images/sync-5.jpeg" class="img-responsive" alt="">

>注意事项：
1. 增加系统管理员可备份到共享空间
2. 备份只备份当前那一次的任务，之后本地有任何的修改都不会备份到云盘，要重新启动备份任务，才会显示修改后的结果
3. 选择定时备份，到定时的那个时间点自动备份，每天备份一次。