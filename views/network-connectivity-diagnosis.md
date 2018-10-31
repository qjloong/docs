{% import "views/_helper.njk" as docs %}
# 网络连通性诊断流程

本文适用于企业内网署了一粒云系统，并开通了外网访问服务的用户。或云主机部署了一粒云，并配置了域名解析，出现的无法确认的网络连通性的诊断。


### DNS 诊断 (这里以官网测试环境为例)

```
dig app.yliyun.com
```

上述命令会给出 DNS 查询的结果，以下是部分输出：

```
// ...

;; ANSWER SECTION:
app.yliyun.com.		600	IN	A	114.115.203.2

;; Query time: 1 msec
;; SERVER: 192.168.0.1#53(192.168.0.1)
;; WHEN: Mon Oct 29 18:05:01 CST 2018
;; MSG SIZE  rcvd: 48

```

你需要在被诊断的设备和正常的设备下分别运行该命令，然后对比两者的结果（`ANSWER SECTION` 部分），如果结果不同说明发生了 DNS 劫持。如果域名无法解析可能是你没有连接到互联网，或者 DNS Server（上面 `SERVER: 192.168.0.1` 的部分）存在故障。

如果域名无法解析或确实存在 DNS 劫持，可以尝试将设备上的 DNS Server 配置成更可靠的服务商（例如 DNSPod 119.29.29.29、阿里 DNS 223.5.5.5）。若更换后仍无法解析出正确的结果，需要向你的运营商（电信、联通等）投诉。


### 延迟和丢包诊断


可以先用 ping 进行简单的确认：

```
ping app.yliyun.com
```

在积累一段时间数据后可以按 `Ctrl-C` 退出，会打印这样的结果：

```
PING app.yliyun.com (114.115.203.2): 56 data bytes
64 bytes from 114.115.203.2: icmp_seq=0 ttl=47 time=44.103 ms
64 bytes from 114.115.203.2: icmp_seq=1 ttl=47 time=41.142 ms
64 bytes from 114.115.203.2: icmp_seq=2 ttl=47 time=42.958 ms
64 bytes from 114.115.203.2: icmp_seq=3 ttl=47 time=42.648 ms
64 bytes from 114.115.203.2: icmp_seq=4 ttl=47 time=44.220 ms
64 bytes from 114.115.203.2: icmp_seq=5 ttl=47 time=43.143 ms
64 bytes from 114.115.203.2: icmp_seq=6 ttl=47 time=42.611 ms
^C
--- app.yliyun.com ping statistics ---
7 packets transmitted, 7 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 41.142/42.975/44.220/0.960 ms
```

`0.0% packet loss` 是指丢包率，一般 3% 以下是可以接受的，否则会导致数据反复重传，连接质量下降；如果丢包率为 100% 说明完全无法连通，请检查本地网络或向运营商投诉。

`min/avg/max/stddev = 41.142/42.975/44.220/0.960 ms` 是指延迟的最小、平均、最大值和标准差，正常情况延迟会在 100ms 以下。

如果检测到了延迟或者丢包，需要用 mtr 进一步确认发生延迟或丢包的位置：

```
sudo mtr -n app.yliyun.com
```

mtr 会给出单独 ping 网络上每一个路由节点的延迟（Avg）和丢包（Loss%）情况，从上到下依次是由近（用户端）到远（LeanCloud 服务器）：

```
...

Keys:  Help   Display mode   Restart statistics   Order of fields   quit
                                       Packets               Pings
 Host                                Loss%   Snt   Last   Avg  Best  Wrst StDev
 1. 192.168.0.1                       0.0%    22    0.6   0.9   0.6   2.0   0.4
 2. 113.88.64.1                       0.0%    22    4.6   7.8   4.0  18.9   3.4
 3. 202.105.154.9                     0.0%    21    5.6   7.3   4.7  19.3   4.5
 4. 183.56.65.26                     81.0%    21    4.8   4.6   4.3   4.8   0.2
 5. 202.97.80.21                      0.0%    21   43.4  43.0  40.6  55.5   3.1
 6. 220.181.177.126                  90.0%    21   38.5  39.1  38.5  39.8   0.9
 7. 218.30.102.242                   47.6%    21   43.0  44.0  42.1  47.7   1.7
 8. 218.30.102.250                   47.6%    21   41.8  50.6  41.8 119.3  23.0
 9. ???
10. ???
11. ???
12. ???
13. ???
...

```

{{ docs.note("需要注意并不是所有运营商都允许使用 mtr，也并不是网络中的每个节点都会回应 ping 检测（所以有一部分节点是 `???`）。") }}

我们应该由远至近（由下至上）去检查发生延迟或丢包的节点，会出现中间某个节点延迟或丢包较高，但如果下一个节点没有受到影响，那么说明延迟或丢包不是这个节点造成的。

一旦找到导致延迟或丢包的节点，我们可以去第三方的 IP 库（例如 [ipip.net](http://www.ipip.net/)）查询这个 IP 的归属者：

- 如果查询结果类似「局域网」，说明延迟或丢包发生在你的浏览器或末端运营商处，可能是 Wifi 信号差、路由器负荷过高或者达到了限速，可以尝试重启路由器或向你的运营商投诉。
- 如果查询结果类似「中国 联通骨干网」，说明延迟或丢包发生在省市级别的线路上，需要等待电信运营商采取措施，这类故障通常会比较快地被修复。
- 如果查询结果类似「上海市 联通」，说明延迟或丢包发生在市县一级的线路上，如果靠近用户端需要向运营商投诉。或者可以 [联系我们](/help.html)。


### 安装诊断工具

- macOS 自带 ping 和 curl，mtr 和 openssl 需要 `brew install mtr openssl`，brew 需要在 <https://brew.sh/> 安装。
- Windows & Linux 使用 mtr：[使用 MTR 诊断网络问题](https://meiriyitie.com/2015/05/26/diagnosing-network-issues-with-mtr)。
- 在 Android 或 iOS 上可以使用 [HE.NET Network Tools](http://networktools.he.net/) 提供的 DNS、Ping 和 Traceroute（类似 mtr）。

