## Kode v3 是一个轻量级的 MVC 框架 ##

Kode 是为了结合使用 cocos2d-x 框架开发移动游戏而开发一个轻量级 MVC 框架。Kode 已经应用在一款大型的横版格斗手游，实用性和稳定性都可以保证，同时 Kode 也会持续地更新，随着项目开发 Kode 已更新到 v3 了，v3 做了按需加载（lazy loading）优化，对于大型的应用（游戏）加载优化有很明显提高。另外 v3 还对模块组织进行了调整，每个模块的所有文件都在同一个文件夹下，模块目录结构更加清晰。

### 什么是 MVC(Model-View-Controller)？ ###

Kode 增加了 S 和 E ，但还是 MVC 的思想。

- **M(Model)** 层，存储数据的地方，只提供2种接口，gets 和 sets 接口。
- **V(View)** 层，界面显示的地方，处理界面的显示并提供 update 接口（提供给 controller 调用）来更新界面。
- **C(Controller)** 层，处理游戏逻辑的地方，她需要与其他所有层打交道，她是总管。
- **S(Service)** 层，负责与服务器端（如果用在客户端，完全可以用在服务器端）交互，只提供2中接口，请求和响应接口。
- **E(Event)** 消息（事件）层，Controller 与 Controller 之间，Model 与 Controller，Service 与 Controller 之间的交互都是通过消息传递。

注意：Controller 是不能直接获取它的对象，要与 Controller 交互只能通过消息传递。

### 模块创建工具 ###

- Linux/Unix/Mac 下运行 makeluamodule 来创建新的模块
- windows 下运行 makeluamodule.exe 来创建新的模块

运行工具，根据提示自动创建一个完整模块所需文件和配置。

### 提供学习示例 ###

- samples 目录下可以找到结合 cocos2d-x 3.x 的示例，会持续更新
- 在 lua 环境直接运行 main.lua 也可以看到自带的示例

运行测试，在终端下运行：./main.lua，运行前请确保你已经安装了 lua 环境

输出：

	[Info]
	app start
	Testing roleController
	csv data: {
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
	role service: request getting bag size
	role service: onBagGetSize
	role bag info: {
		type = "role_bag",
		name = "bag_get_size",
		body = {
			size = 32,
		}
	}
	role model: get bag size: 32
