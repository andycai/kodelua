kode.controller = kode.notifier:extend{
	controllerName = "BaseController";
	viewComponent = {}
}

function kode.controller:new(viewComponent)
	assert(self.viewComponent ~= nil, "need a viewComponent")
	self.viewComponent = viewComponent

	o = {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function kode.controller:onRegister()
end

function kode.controller:onRemove()
end

function kode.controller:listNotificationInterests()
	return {}
end

function kode.controller:handleNotification(notification)
	if notification.name then
		local action = "action_" .. notification.name
		if self[action] and isfunction(self[action]) then
			self:acton(notification)
		end
	end
end