if kode == nil then return end

local maingamesceneController = BaseController:extend{
	name = "maingamesceneController2013-1-16";
}
local meta = maingamesceneController

function meta:onRegister()
	-- body
end

function meta:listNotificationInterests()
	return {
		-- roleModel.EVENT_BAG_GET
		appFacade.EVENET_START_APP
	}
end

function meta:handleNotification(notification)
	-- this=self
	if notification.name == appFacade.EVENET_START_APP then
		-- login
		roleService:reqOnline()
		-- bagService:reqBagGet()
		-- bagService:onBagGet({})
	elseif notification.name == roleModel.EVENT_BAG_GET then
		--暂时这里显示界面
		MainGameScence = self.viewComponent
		local scene=MainGameScence.new()
		display.replaceScene(scene)
		c=CCLayer:create()
		scene:addChild(c)
		MainGameScence.btn:registerScriptTapHandler(self.actorInfomationBtnCall)
		MainGameScence.iconBagBtn:registerScriptTapHandler(self.bagpaneBtnCall)
	end
end

-- private action method

function meta:actorInfomationBtnCall()
	ismove=not ismove
	if ismove then
		lhelper.moveTo(MainGameScence.movelayer, {y = -display.cy+60, time = 0.2})
		else
		lhelper.moveTo(MainGameScence.movelayer, {y = -display.cy, time = 0.2})
		
	end
	-- this.test()
	self.test()	-- 可以直接使用 self
end

function meta:bagpaneBtnCall()
	bag=require "ctrl.bag" -- 使用 bagModel 就可以了，不用require
	bag.actionBagBuyPos()
end

function meta:test()
	print("test")
end

return meta