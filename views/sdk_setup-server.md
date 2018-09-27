{% extends "./sdk_setup.tmpl" %}
{% set platform_name = "Server" %}
{% set java_sdk_latest_version = '0.1.6' %}

{% block language %}server{% endblock %}

{% block init_with_app_keys %}

然后导入 leancloud，并在 main 函数中调用 AVOSCloud.initialize 方法进行初始化：

```java
public static void main(String[] args){
    // 参数依次为 AppId、AppKey、MasterKey
    AVOSCloud.initialize("{{appid}}","{{appkey}}","{{masterkey}}");
}
```
{% endblock %}

{% block sdk_switching_node %}


``` java

public static void main(String[] args){
        // 启用北美节点
        AVOSCloud.useAVCloudUS();
        // 初始化参数依次为 AppId, AppKey, MasterKey
        AVOSCloud.initialize("{{appid}}","{{appkey}}","{{masterkey}}");
}
```
{% endblock %}

{% block save_a_hello_world %}


``` java
     AVObject testObject = new AVObject("TestObject");
     testObject.put("words","Hello World!");
     testObject.save();
```
{% endblock %}

{% block libs_tool_automatic %}

通过 maven 配置相关依赖

``` xml
	<dependencies>
		<dependency>
			<groupId>cn.leancloud</groupId>
			<artifactId>java-sdk</artifactId>
			<version>{{java_sdk_latest_version}}</version>
		</dependency>
	</dependencies>
```

或者通过 gradle 配置相关依赖
```groovy
dependencies {
  compile("cn.leancloud:java-sdk:{{java_sdk_latest_version}}")
}
```
{% endblock %}
