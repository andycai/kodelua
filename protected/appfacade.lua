appFacade = kode.facade:extend{
	EVENT_START_APP = "StartApp";
	-- controllers = {
	-- 	bagController = require "controller.bagcontroller"
	-- }
}

function appFacade:startup(...)
	self:sendNotification(self.EVENT_START_APP)
end

-- register contoller
function appFacade:register(controller, viewComponent)
	local ctrlInstance = controller:new(viewComponent)
	if controller and viewComponent then
		self:registerController(ctrlInstance)
	end
end

return appFacade