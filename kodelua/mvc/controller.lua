local Controller = KNotifier:Extend{
	controllerName = "BaseController";
	viewComponent = {}
}

function Controller:New(viewComponent)
	assert(self.viewComponent ~= nil, "need a viewComponent")
	self.viewComponent = viewComponent

	o = {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function Controller:onRegister()
end

function Controller:onRemove()
end

function Controller:ListNotificationInterests()
	return {}
end

function Controller:HandleNotification(notification)
	if notification.name then
		local action = "action" .. notification.name
		if self[action] then
			self:acton(notification)
		end
	end
end

return Controller