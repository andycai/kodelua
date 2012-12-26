local Controller = require "kodelua.mvc.controller"
local bagModel = require "model.bagmodel"
local log4j = require "kodelua.log4j"

local bagCtrl = Controller:Extend{
	name = "bagCtrl"
}

-- function bagCtrl:onRegister()
-- 	self:AddListener(bagModel.EVENT_BAG_GET, self.onBagGet)
-- end

function bagCtrl:ListNotificationInterests()
	return {
		bagModel.EVENT_BAG_GET
	}
end

function bagCtrl:HandleNotification(notification)
	if notification.name == bagModel.EVENT_BAG_GET then
		log4j.Debug("Execute notice: %s", notification.name)
	end
end

-- param table
function bagCtrl:onBagGet(param)
	local util = require "kodelua.util"
	util.Dump(param)
	print(self.Name)
	print("onBagGet")
end

function bagCtrl:ActionTidy(param)
	print("ActionTidy")
end

function bagCtrl:ActionBuyPos(param)
	print("ActionBuyPos")
end

function bagCtrl:ActionSellProps(param)
	print("ActionSellProps")
end

return bagCtrl