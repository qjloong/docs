{% import "views/_helper.njk" as docs %}

# RAID-磁盘阵列


## RAID概念

```
RAID是英文Redundant Array of Independent Disks的缩写，中文简称为独立冗余磁盘阵列。
简单的说，RAID是一种把多块独立的硬盘（物理硬盘）按不同的方式组合起来形成一个硬盘组（逻辑硬盘），
从而提供比单个硬盘更高的存储性能和提供数据备份技术。

组成磁盘阵列的不同方式称为RAID级别（RAID Levels）。
在用户看起来，组成的磁盘组就像是一个硬盘，用户可以对它进行分区，格式化等等。

总之，对磁盘阵列的操作与单个硬盘一模一样。不同的是，磁盘阵列的存储速度要比单个硬盘高很多，
而且可以提供自动数据备份。数据备份的功能是在用户数据一旦发生损坏后，利用备份信息可以使损坏数据得以恢复，
从而保障了用户数据的安全性。
```


## 主要目的

虽然RAID包含多块硬盘，但是在操作系统下是作为一个独立的大型存储设备出现。利用RAID技术于存储系统的好处主要有以下三种：

> 1. 通过把多个磁盘组织在一起作为一个逻辑卷提供磁盘跨越功能；
> 2. 通过把数据分成多个数据块（Block）并行写入/读出多个磁盘以提高访问磁盘的速度；
> 3. 通过镜像或校验操作提供容错能力；

## 简单分类：

RAID技术经过不断的发展，已经拥有多种级别，不同RAID 级别代表着不同的存储性能、数据安全性和存储成本。

<img src="images/raid/raid1.jpeg" class="img-responsive" alt="">

## 操作步骤：

> 一粒云系统使用过程中，Raid一般在系统存储扩容时需要用到.登录管理后台-【磁盘扩容】：

### 1、依次选择”Hardware”-“Linux RAID”，打开Linux Raid设置界面 （我们以RAID5为例） 
其它参数都选择默认配置，点击”Create RAID device of level”按钮

> 注：如只对单个盘进行RAID，则选择”Linear Concatenated”类型

<img src="images/raid/raid-2.jpeg" class="img-responsive" alt="">


### 2、打开RAID创建页面，如下图所示:

途中标记区域显示为目前已插入的磁盘列表，按住”SHIFT”+鼠标选择要做RAID5的磁盘。其他配 置默认，点击下方”Create”按钮创建RAID.

<img src="images/raid/raid-3.jpeg" class="img-responsive" alt="">


### 3、如成功创建RAID，返回上一步将看到做完RAID的设备信息，我们创建后的RAID信息如下图标记框：

点击设备名称“/dev/md3”初始化RAID磁盘

<img src="images/raid/raid-4.jpeg" class="img-responsive" alt="">


### 4、格式化已经成功的raid 盘符

推荐使用xfs 格式进行格式化， 如果磁盘空间大约 16TB，格式化时必须要选择xfs

<img src="images/raid/raid-5.jpeg" class="img-responsive" alt="">

点击create

<img src="images/raid/raid-6.jpeg" class="img-responsive" alt="">


如下图提示格式化成功

<img src="images/raid/raid-7.jpeg" class="img-responsive" alt="">


### 5、挂载到linux 系统中

磁盘格式化完后还要将磁盘挂载到系统中，
返回主目录，如下图顺序依次选择

<img src="images/raid/raid-8.jpeg" class="img-responsive" alt="">


### 6、注意：新增的路径不要与上列表中的路径重复；推荐命名格式：gdata_xxxx ,xxx 可以随意填写,如下图开始挂载。

> 在第1步选择”Linear Concatenated”类型的按蓝标框所示

<img src="images/raid/raid-9.jpeg" class="img-responsive" alt="">


### 7、挂载完成后返回，如下图标记框 挂载成功

<img src="images/raid/raid-10.jpeg" class="img-responsive" alt="">

注：如要挂载多块盘，重复上述步骤，注意挂载目录不要重复，否则挂载失败。

如下图失败案例

进入linux 编辑/etc/fstab 删除与挂载失败对应的那一行，重启服务

<img src="images/raid/raid-11.jpeg" class="img-responsive" alt="">
