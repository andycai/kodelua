local bagController = KController:Extend{
	Name = "bagController2013-1-10";

	onRegister = function(self)
		-- 
	end;

	ListNotificationInterests = function(self)
		return {
			roleModel.EVENT_BAG_GET
		}
	end;

	HandleNotification = function(self, notification)
		if notification.name == roleModel.EVENT_BAG_GET then
			log4j.Debug("Execute notice: %s", notification.name)
			self.actionBagGet()
		end
	end;

	-- private action method

	actionBagGet = function(self, param)
		-- test for reading csv data
		nums, data, labels = csv.Load("./kodelua/tests/player.csv")
		print("Player data rows: ", nums)
		util.Dump(labels, "Label")
		util.Dump(data, "Player Data")
	end;

	actionBagTidy = function(self, param)
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

return bagController