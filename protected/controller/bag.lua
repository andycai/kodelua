local bagController = BaseController:extend{
	name = "bagController2013-1-10";
}
local meta = bagController

function meta:onRegister()
	-- body
end

function meta:listNotificationInterests()
	return {
		bagModel.EVENT_BAG_GET,
		appFacade.EVENT_START_APP
	}
end

function meta:handleNotification(notification)
	if notification.name == bagModel.EVENT_BAG_GET then
		log4l.debug("Execute notice: %s", notification.name)
		self:actionBagGet(notification.body)
	elseif notification.name == appFacade.EVENT_START_APP then
		local nums, data, labels = kode.csv.load("./kode/tests/player.csv")
		puts(kode.i18n("Testing %s", "bagController"))
		kode.dump(data)
	end
end

-- private action method

function meta:actionBagGet(param)
	-- body
end

return meta