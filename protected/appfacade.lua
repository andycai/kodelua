local facade = require "kodelua.mvc.facade"

local appFacade = facade:Extend{
	NOTI_START_APP = "StartApp";
	-- controllers = {
	-- 	bagController = require "controller.bagcontroller"
	-- }
}

function appFacade:Startup(...)
	self:SendNotification(self.NOTI_START_APP)
end

-- register contoller
function appFacade:Register(controller, viewComponent)
	local ctrlInstance = controller:New(viewComponent)
	if controller and viewComponent then
		self:RegisterController(ctrlInstance)
	end
end

return appFacade