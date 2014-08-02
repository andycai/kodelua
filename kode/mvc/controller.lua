kode = kode or {}

kode.controller = kode.notifier:extend{
	controllerName = "kode_controller",
	moduleName = nil,
	viewComponent_ = nil
}

function kode.controller:new(moduleName)
	assert(moduleName ~= nil and moduleName ~= "", "module must be not empty")
	self.moduleName = moduleName

	local o = {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function kode.controller:getView()
	if self.viewComponent_ == nil then
		self.viewComponent_ = kode.facade:loadView(self.moduleName)
		assert(self.viewComponent_ ~= nil, self.moduleName .. " view must be not nil")
	end
	return self.viewComponent_
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
		local action = "action_" .. notification.name .. "_"
		if self[action] and isfunction(self[action]) then
			self[action](self, notification)
		end
	end
end