local bagController = BaseController:extend{
	name = "bagController2013-1-10";
}
local meta = bagController

function meta:onRegister()
	-- body
end

function meta:listNotificationInterests()
	return {
		bagModel.EVENT_BAG_GET
	}
end

function meta:handleNotification(notification)
	if notification.name == bagModel.EVENT_BAG_GET then
		log4l.debug("Execute notice: %s", notification.name)
		self:actionBagGet(notification.body)
	end
end

-- private action method

function meta:actionBagGet(param)
	-- body
end

return meta