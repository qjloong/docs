# YLIYUN Documentation
[![Build Status](https://travis-ci.org/leancloud/docs.svg)](https://travis-ci.org/leancloud/docs)
[![devDependency Status](https://david-dm.org/leancloud/docs/dev-status.svg)](https://david-dm.org/leancloud/docs#info=devDependencies)

YLIYUN 文档中心

## 技术咨询

如有问题，请 [提交工单](http://www.yliyun.com)。若文档内容有误，可以直接在文档页面上留言或提交 Github Issue。

## 说明

这个项目是 [YLIYUN 文档](http://www.yliyun.com/docs/) 上的所有文档的 Markdown 格式的源码，通过转换最终被渲染成 HTML 文档]。因此 Markdown 文件里部分链接写的是最终渲染后的链接，如果直接点击会出现 404 错误。

## 贡献

我们欢迎所有用户提交 PR 或 issue 为我们贡献或者修正错误，YLIYUN 衷心感谢您的贡献。

## 内部贡献

为避免在所提交 PR 中出现与修改内容无关的 Merge pull request 的 commits，推荐使用以下流程提交 PR：

1. 本地切换到 master 分支
1. rebase
1. 新建分支 new branch 进行修改
1. 提交 PR，如有相关的 issue 在注释中增加 `Fixes #???`。问号为 issue 的编号。

合并 PR 时，如果 commits 历史不重要，可以选择 Squash and Merge 来合并，合并后删除相关的分支。

PR 合并后，要让改动最终生效还需要通过 Jenkins 执行 `cn-avoscloud-docs-prod-ucloud` 任务进行发布。


## 目录结构

```
├── README.md                          // 说明文档
├── archive                            // 已下线存档的文档，请勿更新
├── custom                             // 文档页面样式及 JavaScript 代码
├── images                             // 文档中引用的所有图片
├── md                                 // 临时目录（文档均为自动生成，因为不要修改）
├── dist                               // 编译之后生成的文件将会在此目录下
├── private                            // 未完成、未发布的文档临时保存在这里，以便让重建全站文档索引的系统任务忽略这些文件
├── react                              // 文档评论功能所需要用的 React 组件
├── server_public                      // 文档评论功能所需要用的 React 组件
├── templates                          // 文档网站的 HTML 页面模板
├── views                              // Markdown 格式文档的模板文件和源文件，使用时会被编译到 md 目录中
├── app.coffee
├── app.json
├── CHANGELOG.md                       // changelog 记录
├── circle.yml
├── CONTRIBUTING.md                    // 贡献指南
├── package.json
└── ...
```

## 预览

开发服务基于 Grunt，所以需要有 Nodejs 环境，通过 NPM 安装测试需要的依赖

安装 Grunt

```bash
$ sudo npm install -g grunt-cli
```

安装需要的依赖

```bash
$ npm install
```

本地启动一个 HTTP Server，然后打开浏览器访问 <http://localhost:3000> 即可

```bash
$ grunt serve
```

## 版本更新

- 请通过 `grunt release` 命令自动 bump `package.json`、自动打标签，请不要手动更新
- 请按照 `CONVENTIONS.md` 的格式书写有意义的 commits，`CHANGELOG.md` 会被自动生成，请不要手动修改

## 一套模板多份渲染

有些文档的相似度非常高，所以可以使用一份模板，多分变量渲染的方式一次性生成多份文档，比如 「LeanEngine 指南」的文档就是这样生成的。这份文档分为三个运行时：Node.js、Python、云引擎 2.0。最终效果可见 [LeanEngine (Node.js 环境)](https://leancloud.cn/docs/leanengine_guide-node.html) 和 [LeanEngine（Python 环境）](https://leancloud.cn/docs/leanengine_guide-python.html)。这类文档编写方式如下：

* 在 `views` 目录先编写一份「模板」（以 `tmpl` 作为扩展名），将文档的主体部分完成，将文档之间不一样的部分（比如不同语言的代码片段）使用：

  ```
  {% block <blockName> %}{% endblock %}
  ```

  括起来。可以参考 [leanengine_guide.tmpl](https://github.com/leancloud/docs/blob/master/views/leanengine_guide.tmpl)。
* 在 `views` 目录里编写多份渲染变量（以 `md` 作为文件扩展名）。第一行表明自己继承哪个模板：

  ```
  {% extends "./<your-tmpl-file>" %}
  ```

  后续的内容就是用：

  ```
  {% block <blockName> %}<不同文档之间的差异>{% endblock%}
  ```

  来替换模板中存在的 block。可以参考 [leanengine_guide-node.tmpl](https://github.com/qjloong/docs/blob/master/views/leanengine_guide-node.md)
* 生成文档：使用下列命令会在 md 文件夹中生成最终的 md 文件：

  ```
  grunt nunjucks
  ```

  同样支持 `grunt server` 命令，该命令最终会执行 `watch` 插件，此时修改模板文件，或者变量文件都会自动重新生成最终的 md 文件（可能需要等待 2~4 秒）。
* 记得将这种方式生成的 md 文件添加到 [.gitignore](https://github.com/qjloong/docs/blob/master/.gitignore) 文件中，确保这类文件不会被提交。

**注意：如果在模板中需要渲染 `{{appid}}` 这样的 AngularJS 变量，则必须在模板文件的最上方先定义好一个新变量，如 `appid`，其值为 `'{{appid}}'`，例如：**

```
{% set appid = '{{appid}}' %}
{% set appkey = '{{appkey}}' %}
{% set masterkey = '{{masterkey}}' %}
```

这样，在生成的 html 文档中，`{{appid}}` 才可以被正确渲染，否则，它会被替换为空值，原因是 nunjucks 在上下文中找不到该变量的定义。

其他常用的 [nunjucks 模板方法](https://mozilla.github.io/nunjucks/templating.html) 或者 [jinja](http://jinja.pocoo.org/docs/dev/templates/)，以下为快速参考：

```
{# 这是注释，用 <!-- --> 无效 #}

{% if numUsers < 5 %}...{% endif %}
{% if i != "String" %}...{% endif %}
// boolean 的否定要用 not 而不是 !
{% if not isNew %}...{% endif %}
{% if users and showUsers %}...{% endif %}
{% if i == 0 and not hideFirst %}...{% endif %}
{% if (x < 5 or y < 5) and foo %}...{% endif %}

// 复用文档片断
{% macro ... %}
{% include ... %}
```

### 辅助工具

「一套模板多分渲染」的不同渲染文件编写起来比较困难，需要先从主模板上找到变量在对应到渲染文件，所以开发了一个简单的工具来简化这一步骤。使用方式如下：

* 安装需要的依赖，该步骤只需要执行一次：

  ```
  npm install
  ```

* 启动辅助工具的本地 webServer，使用以下命令：

  ```
  $ node server
  ```
* 使用浏览器打开 http://localhost:3001，将会看到一个「选择模板」的下拉列表框，该列表框里会显示 `views/<tmplName>.tmpl` 的所有模板文件，文件名的 `tmplName` 部分是下拉列表框选项的名称。选择你需要编写的模板（比如 `leanengine_guide`）。
* 你会看到模板文件被读取，其中所有 `{% block <blockName> %}<content>{% endblock %}` 部分的下面都会有一些按钮。这些按钮表示该「模板」拥有的不同「渲染」，也就是对应的 `views/<tmplName>-<impl>.md` 文件，文件名的 `impl` 部分是按钮的名称。
* 点击对应的按钮，即可看到「渲染」文件中对应 `block` 的内容已经读取到一个文本域中，如果为空，表明该「渲染」文件未渲染该 block，或者内容为空。
* 在文本域中写入需要的内容，然后点击保存，编写的内容就会保存到对应的「渲染」文件的 block 中。
* 最后建议打开「渲染」文件确认下内容，没问题即可通过 `grunt serve` 查看效果。当然整个过程打开 `grunt serve` 也是没问题的，它会发现「渲染」文件变动后重新加载。

有问题请与 <loong@yliyun.com> 联系。

## License

LGPL-3.0 感谢leancloud提供项目模版
