if kode == nil then return end

local Event = require "app.config.events"

local {{name}}Controller = BaseController:extend{
	name = "{{name}}Controller{{time}}";
}
local meta = {{name}}Controller

function meta:onRegister()
	-- body
end

function meta:listNotificationInterests()
	return {
		Event.EVENT_ACTION_NAME
	}
end

function meta:handleNotification(notification)
	if notification.name == Event.EVENT_ACTION_NAME then
		-- body
	end
end

-- private action method

function meta:actionFunction(param)
	-- body
end

return meta