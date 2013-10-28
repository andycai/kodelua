local Event = require "app.config.events"

if kode == nil then return end

appFacade = kode.facade:extend{
}

Event.EVENT_START_APP = "StartApp";

function appFacade:startup()
	self:sendNotification(Event.EVENT_START_APP, {notice="startup"})
end

-- register contoller
function appFacade:register(controller, viewComponent)
	local ctrlInstance = controller:new(viewComponent)
	if controller and viewComponent then
		self:registerController(ctrlInstance)
	end
end

return appFacade