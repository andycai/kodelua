local {{name}}Controller = KController:Extend{
	Name = "{{name}}Controller{{time}}";

	onRegister = function(self)
		-- body
	end;

	ListNotificationInterests = function(self)
		return {
			{{name}}Model.EVENT_ACTION_NAME
		}
	end;

	HandleNotification = function(self, notification)
		if notification.name == {{name}}Model.EVENT_ACTION_NAME then
			-- body
		end
	end;

	-- private action method

	actionFunction = function(self, param)
		-- body
	end;

}

return {{name}}Controller