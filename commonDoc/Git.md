# Git 常见问题

## 如何使用Git Flow

Git Flow是基于git的一种版本管理方法，它定义了各种分支的作用和合并时的操作标准。

![git flow](./images/gitflow.png)

master - 发布主线
develop - 开发主线
feature - 功能开发分支，从develop上最新的节点创建，完成后被develop合并。
release - 发布分支，从develop上最新的节点创建，完成后被master和develop分别合并。
hotfix - bug修复分支，从master上最新的节点创建，完成后被master和develop分别合并。

### 基于sourcetree的Git Flow操作流程

[source tree 下的 Git Flow](http://www.cnblogs.com/cocoajin/p/4171312.html)

### 使用Git Flow的常见问题

#### 1.完成一个feature/hotfix/release时的合并操作出现冲突如何解决

  首先明确当前所在分支是哪个。

  再决定冲突的解决方式：使用我的内容/使用他的内容/手动解决

#### 2.如何回滚一次提交(commit)

  首先明确这次提交是否已经被提交了到远端（origin）。

  如果还没有push到origin,可以使用reset操作。

  如果已经push到了origin,建议使用revert操作,
  创建一个针对该commit的反向修改commit。

#### 3.如何回滚一次合并(merge)

  首先明确这次提交是否已经被提交了到远端（origin）。

  如果还没有push到origin,可以使用reset操作。

  如果已经push到了origin,
  只能使用命令行操作git revert -m,
  提交一个反向文件修改的commit。
  但是这样操作依然会存在一个问题。

#### 4.为什么会出现HEAD？

  如果你处于HEAD，表示你目前的working copy不处于任何一个分支下。

  如果有在当前HEAD下做修改的需求，应该先使用create branch在当前位置创建一个分支。将后续的修改提交到这个新建的分支上。

## Cherry Pick

>git cherry-pick可以选择某一个分支中的一个或几个commit(s)来进行操作。例如，假设我们有个稳定版本的分支，叫v2.0，另外还有个开发版本的分支v3.0，我们不能直接把两个分支合并，这样会导致稳定版本混乱，但是又想增加一个v3.0中的功能到v2.0中，这里就可以使用cherry-pick了,其实也就是对已经存在的commit 进行再次提交.

[git cherry-pick 使用指南](http://www.jianshu.com/p/08c3f1804b36)

## 总结

1.使用work flow的操作流程，可以保证线上版本和开发版本的分离，以便开发者分别去处理各自的问题。

2.不要急于把你的提交（commit）推送到远端（push）。当修改只存在于本地的working copy时，一切的撤销和回滚操作都可以简单的进行。