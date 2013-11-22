local Event = require "app.config.events"

local bagController = BaseController:extend{
	name = "bagController2013-1-10";
}
local meta = bagController

function meta:onRegister()
	-- body
end

function meta:listNotificationInterests()
	return {
		Event.EVENT_BAG_GET,
		Event.EVENT_START_APP
	}
end

function meta:handleNotification(notification)
	if notification.name == Event.EVENT_BAG_GET then
		puts("Execute notice: %s", notification.name)
		self:actionBagGet(notification.body)
	elseif notification.name == Event.EVENT_START_APP then
		local nums, data, labels = kode.loadcsv("./kode/tests/player.csv")
		puts(kode.i18n("Testing %s", "bagController"))
		puts(data)
	end
end

-- private action method

function meta:actionBagGet(param)
	-- body
end

return meta