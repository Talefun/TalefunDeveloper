# 代码分支管理指南(试行版本)

## 介绍

这是我们团队的 Git 分支管理规范。每个人对工具的使用往往各有偏好，各种方法各有利弊，无所谓对错。但涉及团队协作的方面需要有一些一致的规范，所以请大家务必遵守。

除了一致性之外，这个规范的目的是以下几点：

* 确保可以轻易确定特定时间发布或运行的版本。在新发布的程序存在重大缺陷时，可以尽快 rollback 到上一个稳定版本。
* 在需要修复紧急 bug 并尽快发布时，可以只发布必要的 bugfix 而不同时发布还不应发布的其他改动。

## branch 和 tag

每个远端 git 仓库下有且仅有以下的 branch 和 tag。

Branch: master 和 develop。 develop 对应目前的开发分支，所有的 pull request master 是当前发布的分支，在这个分支只能增加从 develop 准备 release 发的 commit。详见本文后面的说明。

Tag: 对应每个发布版本的 tag。SDK 和应用程序的 tag 遵照 \<major\>.\<minor\>.\<patch\> 的命名，如 2.5.1；服务端程序的 tag 以发布的日期命名，如 2014.11.13，如果有 bugfix，则在后面增加小写字母，如 2014.11.13 后是 2014.11.13a，然后是 2014.11.13b。

## GitFlow

本地开发的分支管理推荐使用gitflow进行分支管理，详细说明请参照[GitFlow 说明讲解](./Git)

## 发布新版流程

* 创建新的 release 分支，分支名称为准备发布的版本名称;

* 在该 release 分支上进行版本的发布和测试，并且修复测试发现的问题，提交一个或者多个 commit;

* 在测试通过后，完成当前 release， develop 和 master 会合并该分支，并创建对应的版本 tag 记录。

* 最后的发布内容从最新的 master 节点创建。

## Bugfix 流程

这里的 bugfix 指的是修复已经发布的程序（master branch）中的缺陷。

* 创建新的 hotfix 分支，分支名称为修后准备发布的版本名称;

* 在该 hotfix 分支上完成bug的修复，提交一个或者多个 commit;

* 完成当前 hotfix 分支，develop 和 master 分别合并该hotfix，并在 master 上创建对应的版本 tag 记录。

## 其他

并不是每个 bug 都需要建立hotfix分支来修复，对于不紧急的 bug，可以在 develop 上 fix 后随下一个版本发布。