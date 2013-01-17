
local maingamesceneController = KController:Extend{
	Name = "maingamesceneController2013-1-16";
	
	onRegister = function(self)
		-- 
	end;

	ListNotificationInterests = function(self)
		return {
			roleModel.EVENT_BAG_GET
		}
	end;

	HandleNotification = function(self, notification)
		this=self
		if notification.name == roleModel.EVENT_BAG_GET then
			--暂时这里显示界面
			MainGameScence = self.viewComponent
			display.replaceScene(MainGameScence.new())
			MainGameScence.btn:registerScriptTapHandler(self.actorInfomationBtnCall)
		end
	end;

	-- private action method
	actorInfomationBtnCall=function()
	ismove=not ismove
	if ismove then
		lhelper.moveTo(MainGameScence.movelayer, {y = -display.cy+60, time = 0.2})
		else
		lhelper.moveTo(MainGameScence.movelayer, {y = -display.cy, time = 0.2})
		
	end
	this.test()
	end;
	test=function()
		print("test")
	end;
}

return maingamesceneController