# API管理方式说明文档（待完善）

目前后端服务模块的业务越来越复杂。为了能够统一的管理对外的API，以便前后端联调和交流更加顺畅。新的后端项目开始使用[NEI接口管理平台](https://nei.netease.com)来管理API接口。该工具主要是能够满足以下几点功能需求：

* 按各个后端服务模块划分，进行API的定义，其中涉及

      1.接口路由的定义
      2.发送数据格式的定义
      3.回调数据格式的定义

* 定义完成的API，在发生版本变动的时候，基于RestFull API做版本管理。

* 可以生成便于阅读的API文档

* 可以方便的做接口测试

## NEI平台使用步骤

1. 前往[NEI接口管理平台](https://nei.netease.com)注册账号。

2. 后端开发人员申请开发者权限，前端API使用人员申请测试者权限。

3. 开发者根据项目的实际返回数据格式，构建对应的数据模型。

4. 通过以构建的数据模型来定义对应的API接口。

5. 在接口测试模块，生成对应的测试用例。

6. 前端使用人员可以直接查阅API接口定义以及其文档，也可使用测试用例检测当前的服务是否返回预期的数据。

## NEI平台使用文档

NEI具体的使用，可以参考示例项目[user-center](https://nei.netease.com/project?pid=30886)。

也可以参考官方[文档](https://github.com/NEYouFan/nei-toolkit/blob/master/doc/NEI%E5%9F%BA%E6%9C%AC%E6%A6%82%E5%BF%B5%E4%BB%8B%E7%BB%8D.md)和[视频](https://nei.netease.com/tutorial)。