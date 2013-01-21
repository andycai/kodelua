Kodelua 是一个轻量级的 MVC 框架
========

Kodelua 为了开发手游，结合 Cocos2d-x 而开发一个轻量级的框架。

什么是 MVCS？

- M 就是 Model 层，存储数据的地方，只提供2种接口，gets 和 sets 接口。
- V 就是 View 层，界面显示的地方，处理界面的显示并提供 update 接口（提供给 controller 调用）来更新界面。
- C 就是 Controller 层，处理游戏逻辑的地方，她需要与其他所有层打交道，她是总管。
- S 就是 Service 层，负责与服务器端（如果用在客户端，完全可以用在服务器端）交互，只提供2中接口，请求和响应接口。

## 阅读文档
[开始阅读](kodelua/blob/master/00.md)