local roleController = BaseController:extend{
	name = "roleController2013-1-10";
}
local meta = roleController

function meta:onRegister()
	-- body
end

function meta:listNotificationInterests()
	return {
		roleModel.EVENT_ACTION_NAME
	}
end

function meta:handleNotification(notification)
	if notification.name == roleModel.EVENT_ACTION_NAME then
		-- body
	end
end

-- private action method

local function actionFunction(param)
	-- body
end

return meta