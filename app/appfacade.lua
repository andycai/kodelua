if kode == nil then return end

appFacade = kode.facade:extend{
}

Event.EVENT_START_APP = "app_start";

function appFacade:startup()
	initModule()
	self:send(Event.EVENT_START_APP, {notice="startup"})
end

return appFacade