local bagController = BaseController:extend{
	name = "bagController2013-1-10";
}
local meta = bagController

function meta:onRegister()
	-- body
end

function meta:listNotificationInterests()
	return {
		roleModel.EVENT_BAG_GET
	}
end

function meta:handleNotification(notification)
	if notification.name == roleModel.EVENT_BAG_GET then
		log4l.debug("Execute notice: %s", notification.name)
		self:actionBagGet(notification.body)
		print("create a new bag :")
		--[[scene=CCScene:create()
	
		mybag=self.actionBagGet(self)
	
		scene:addChild(mybag)
		CCDirector:sharedDirector():runWithScene(scene)
		self.actionBagClose(self,mybag)
		self.actionBagClickGeZi(self,mybag)
		print("mybag",mybag)
	    print(mybag:getChildByTag(5):getChildByTag(10):getChildByTag(40))
		print("helllo")--]]
	end
end

-- private action method

function meta:actionBagGet(param)
	-- test for reading csv data
	-- nums, data, labels = kode.csv.Load("./kode/tests/player.csv")
	-- print("Player data rows: ", nums)
	-- kode.dump(labels, "Label")
	-- kode.dump(data, "Player Data")
	-- kode.dump(param)
	bagData=require("resource/ui/bag/bagdata")
	mybag=self.viewComponent.new(500,500,bagData.goods,bagData.bag,bagData.num)
	self.actionBagClose(self,mybag)
	self.actionBagClickGeZi(self,mybag)
	
	return mybag
	--mybag=self.viewComponent.new(500,500,bagData.goods,bagData.bag,bagData.num)
end

function meta:actionBagClose(mbag)--自己调用使用参数，不调用时不使用参数
	local function menuCallbackClose()  --关闭背包
	-- stop test sound effect
	--SimpleAudioEngine:sharedEngine():stopEffect(effectID)
	mbag:removeFromParentAndCleanup(true)
	end	
    mbag:getChildByTag(5):getChildByTag(10):getChildByTag(40):registerScriptTapHandler(menuCallbackClose)
end;

function meta:actionBagClickGeZi(mbag)
	function clickGeZi(tag) --点击格子后触发事件
		
	    local nowGezi=mbag:getChildByTag(5):getChildByTag(10):getChildByTag(tag)
		if(self.viewComponent.pastGezi~=nowGezi) then
		  normal=CCSprite:create("resource/ui/bag/gezi2.png")
		
		nowGezi:setNormalImage(normal);
		pnormal=CCSprite:create("resource/ui/bag/gezi.png")
		
		if(self.viewComponent.pastGezi~=NULL) 
		  then
			self.viewComponent.pastGezi:setNormalImage(pnormal)
		end
	    self.viewComponent.pastGezi=nowGezi
		
		end
		
	end
	for i=1,16 do
		mbag:getChildByTag(5):getChildByTag(10):getChildByTag(i+1):registerScriptTapHandler(clickGeZi)
	end
end

return meta