Kodelua 是一个轻量级的 MVC 框架
========

Kodelua 是为了开发移动游戏，结合使用 cocos2d-x 框架而开发一个轻量级的框架。此框架已经应用在一款大型的横版格斗手游，所以稳定性可以保证，同时也会持续地维护和更新。

什么是 MVCS？

- M 就是 Model 层，存储数据的地方，只提供2种接口，gets 和 sets 接口。
- V 就是 View 层，界面显示的地方，处理界面的显示并提供 update 接口（提供给 controller 调用）来更新界面。
- C 就是 Controller 层，处理游戏逻辑的地方，她需要与其他所有层打交道，她是总管。
- S 就是 Service 层，负责与服务器端（如果用在客户端，完全可以用在服务器端）交互，只提供2中接口，请求和响应接口。

推荐结合 [quick-cocos2d-x](https://github.com/dualface/quick-cocos2d-x) 框架一起使用，quick-cocos2d-x 针对 cocos2d-x 进行的大量的封装，并且能支持屏幕自适应，开发 Android 应用不在烦恼：）。

运行测试，在终端下运行：./main.lua，运行前请确保你已经安装了 lua 环境

输出：

	[Info] sendNotification: name=StartApp, body={
	  notice = "startup",
	}, type=nil
	{
	  1 = {
	    1 = "Andy",
	    2 = "male",
	    3 = "18",
	  },
	  2 = {
	    1 = "Nataly",
	    2 = "female",
	    3 = "18",
	  },
	  3 = {
	    1 = "Peter",
	    2 = "male",
	    3 = "20",
	  },
	}

windows 下运行 makeluamodule.exe 来创建新的模块，自动创建一个完整项目所有的代码和文件。

## 阅读文档
[开始阅读](doc/00.md)
