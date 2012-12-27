local Controller = require "kodelua.mvc.controller"
local log4j = require "kodelua.log4j"
local bagModel = require "model.bag"

local bagCtrl = Controller:Extend{
	name = "bagCtrl";

	onRegister = function(self)
		-- 
	end;

	ListNotificationInterests = function(self)
		return {
			bagModel.EVENT_BAG_GET
		}
	end;

	HandleNotification = function(self, notification)
		if notification.name == bagModel.EVENT_BAG_GET then
			log4j.Debug("Execute notice: %s", notification.name)
			self.actionBagGet()
		end
	end;

	-- private action method

	actionBagGet = function(self, param)
		-- test for reading csv data
	    local util = require "kodelua.util"
		local csv = require "kodelua.csv"
		nums, data, labels = csv.LoadAndSave("./kodelua/tests/player.csv")
		print("Player data rows: ", nums)
		util.Dump(labels, "Label")
		util.Dump(data, "Player Data")
	end;

	actionBagTidy = function(self, param)
		local util = require "kodelua.util"
		util.Dump(param)
		print(self.Name)
		print("actionBagTidy")
	end;

	actionBagBuyPos = function(self, param)
		print("actionBagBuyPos")
	end;

	actionBagSellProps = function(self, param)
		print("actionBagSellProps")
	end
}

return bagCtrl