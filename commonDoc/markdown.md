# Markdown文档说明

## Markdown书写文档规范

Markdown 语法说明:[点击前往](http://wowubuntu.com/markdown/)
Markdown 语法介绍:[点击前往](https://coding.net/help/doc/project/markdown.html)
掌握这几种 Markdown 语法你就够了:[点击前往](https://laravel-china.org/topics/621/you-will-be-able-to-master-these-markdown-grammars)

## 常用编辑器Markdown支持

### Sublime Text安装过程

#### 安装准备：

  找到菜单栏：Preferences → Package Control → Package Control:Install Package；
  没有找到Package Control，那么点击[Package Control](https://packagecontrol.io/) 安装吧，安装完重启Sublime。

#### 安装过程：

  需要的插件：

  [Markdown Editing](https://packagecontrol.io/packages/MarkdownEditing) ：编辑器插件，必须安装。

有2个预览插件可以选择安装：
  [MarkdownLivePreview](https://packagecontrol.io/packages/MarkdownLivePreview):打开md文件的时候，直接左右屏显示编辑窗口和预览页面。但是对列表显示的支持不好。

  ![image](./images/md效果2.png)

  [Markdown Preview](https://packagecontrol.io/packages/Markdown%20Preview):打开一个网页来显示预览画面。

  ![image](./images/md效果3.png)

  在Package Control → Install Package中输入插件的名字，找到相应插件，点击即可自动完成安装，安装完重启Sublime；

  简单设置：Preferences → Package Settings → MarkdownLivePreview → Setting，打开后将左边default的设置代码复制到右边User栏，找到"markdown_live_preview_on_open": false,把false改为true，保存。

### VSCode 安装过程。

VSCode默认支持Markdown文档预览，点击窗口右上角的预览按钮可以打开预览页面。
![image](./images/md效果4.jpg)

如果对预览效果不满意，可以选择安装插件MPE:[前往安装教程](https://shd101wyy.github.io/markdown-preview-enhanced/#/zh-cn/vscode-installation)
![image](./images/md效果1.png)

## Markdown语法检测器

VSCode下推荐安装Markdown语法检测插件markdownlint

![image](./images/md效果5.jpg)