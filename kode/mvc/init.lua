kode = kode or {}

local format = string.format

kode.appPath = "app"
kode.modulePath = "modules"

--[[
class Event
--]]
Event = Event or {}

-- Lazy loading
local eventListeners_ = {}

function Event.getListeners(module)
	return eventListeners_[module]
end

function Event.register(module, events)
	if events and type(events) == "table" and #events > 0 then
		for i, eventName in ipairs(events) do
			if type(eventName) ~= "string" or eventName == "" then
				error(sputs("event name must be a string and is not empty [index:%s]", i))
			else
				if eventListeners_[module] == nil then
					eventListeners_[module] = {}
				end
				table.insert(eventListeners_[module], eventName)
			end
		end
	end
end

--[[
class facade
--]]
kode.facade = kode.object:extend{
	observerMap_ = {},
	loadedModules_ = {}
}

function kode.facade:new()
	error("Singleton cannot be instantiated.")
end

function kode.facade:registerObserver(eventName, observer)
	if not eventName then
		error("facade:registerObserver: eventName is empty")
		return
	end
	if self.observerMap_[eventName] == nil then
		self.observerMap_[eventName] = {observer}
	else
		table.insert(self.observerMap_[eventName], observer)
	end
end

function kode.facade:notifyObservers(event)
	local observers

	if self.observerMap_[event.name] then
		observers = self.observerMap_[event.name]
		for _, observer in ipairs(observers) do
			if self.loadedModules_[observer.name] == nil then
				self:loadModule(observer.name)
			end
			observer:setContext(self.loadedModules_[observer.name])
			observer:notifyObserver(event)
		end
	end
end

function kode.facade:send(eventName, ...)
	body = select(1, ...) or {}
	type_ = select(2, ...) or "nil"
	-- puts("send: name=%s, body=%s, type=%s", eventName, kode.tostring(body), type_)
	self:notifyObservers({name=eventName, body=body, type=type_})
end

function kode.facade:registerModule(module)
	self:loadEvent(module)

	local listeners_ = Event.getListeners(module)
	local observer_
	if listeners_ and #listeners_ > 0 then
		for _, eventName in ipairs(listeners_) do
			observer_ = kode.observer:extend{
				name = module,
				notify = "handleNotification"
			}
			self:registerObserver(eventName, observer_)
		end
	end
end

function kode.facade:getModulePath(module)
	return format("%s.%s.%s", kode.appPath, kode.modulePath, module)
end

function kode.facade:loadController(module, controller)
	local controller_ = controller or module
	local pkg_ = format("%s.%s_c", self:getModulePath(module), controller_)
	local obj_ = require(pkg_)

	return obj_
end

function kode.facade:loadModule(module)
	local controller_ = self:loadController(module)
	assert(controller_ ~= nil, module .. " controller must be not nil")
	self.loadedModules_[module] = controller_

	local model_ = self:loadModel(module)
	if model_ then kode.setglobal(module .. "Model", self:loadModel(module)) end

	local service_ = self:loadService(module)
	if service_ then kode.setglobal(module .. "Service", self:loadService(module)) end
end

function kode.facade:loadModel(module, model)
	local model_ = model or module
	local pkg_ = format("%s.%s_m", self:getModulePath(module), model_)
	local obj_ = require(pkg_)

	return obj_
end

function kode.facade:loadService(module, service)
	local service_ = service or module
	local pkg_ = format("%s.%s_s", self:getModulePath(module), service_)
	local obj_ = require(pkg_)

	return obj_
end

function kode.facade:loadView(module, view)
	local view_ = view or module
	local pkg_ = format("%s.view.%spane", self:getModulePath(module), view_)
	local obj_ = require(pkg_)

	return obj_
end

function kode.facade:loadvo(module, vo)
	local vo_ = vo or module
	local pkg_ = format("%s.%s_vo", self:getModulePath(module), vo_)
	local obj_ = require(pkg_)

	return obj_
end

function kode.facade:loadEvent(module, event)
	local event_ = event or module
	local pkg_ = format("%s.%s_e", self:getModulePath(module), event_)
	
	require(pkg_)
end

--[[
class notifier
--]]
kode.notifier = kode.object:extend()

function kode.notifier:send(name, body, type_)
	kode.facade:send(name, body, type_)
end

function kode.notifier:sendNotification(name, body, type_)
	print("sendNotification() was deprecated please use send() instead")
	self:send(name, body, type_)
end

function kode.notifier:notify(name, body, type_)
	print("notify() was deprecated please use send() instead")
	self:send(name, body, type_)
end

--[[
class observer
--]]
kode.observer = kode.object:extend{
	notify = "",
	name = "",
	context = {}
}

function kode.observer:setContext(context)
	self.context = context
end

function kode.observer:notifyObserver(event)
	self.context[self.notify](self.context, event)
end

function kode.observer:compareNotifyContext(object)
	return object == self.context
end

--[[
class controller
--]]
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
		-- self.viewComponent_ = require(string.format("app.view.%s.%spane", self.moduleName, self.moduleName)) -- deprecated
		self.viewComponent_ = kode.facade:loadView(self.moduleName)
		assert(self.viewComponent_ ~= nil, self.moduleName .. " view must be not nil")
	end
	return self.viewComponent_
end

function kode.controller:onRegister()
end

function kode.controller:onRemove()
end

function kode.controller:handleNotification(notification)
	if notification.name then
		local action = "action_" .. notification.name .. "_"
		if self[action] and isfunction(self[action]) then
			self[action](self, notification)
		end
	end
end