kode.facade = kode.object:extend{
	observerMap = {};
	controllerMap = {}
}

function kode.facade:new()
	log4l.error("Singleton cannot be instantiated.")
end

function kode.facade:registerObserver(notificationName, observer)
	if self.observerMap[notificationName] == nil then
		self.observerMap[notificationName] = {observer}
	else
		table.insert(self.observerMap[notificationName], observer)
	end
end

function kode.facade:notifyObservers(notification)
	local observers
	local observer
	if self.observerMap[notification.name] then
		observers = self.observerMap[notification.name]
		for i=1, #observers do
			observer = observers[i]
			observer:notifyObserver(notification)
		end
	end
end

function kode.facade:removeObserver(notificationName, notifyContext)
	local observers = self.observerMap[notificationName]
	if observers == nil or type(observers) ~= "table" then return end
	for i=1, #observers do
		if observers[i] and observers[i]:compareNotifyContext(notifyContext) then
			log4l.info("Removed Observer notification: %s", notificationName)
			table.remove(observers, i)
			break
		end
	end
	if #observers == 0 then
		self.observerMap[notificationName] = nil
	end

end

function kode.facade:sendNotification(name, ...)
	body = select(1, ...) or {}
	kind = select(2, ...) or ""
	log4l.info("sendNotification: name=%s, type=%s", name, kind)
	self:notifyObservers(kode.notification:extend{name=name, body=body, kind=kind})
end

function kode.facade:registerController(controller)
	if controller.name == nil then 
		error("controller need a Name")
		return
	end
	if self.controllerMap[controller.name] ~= nil then return end

	self.controllerMap[controller.name] = controller
	local interests = controller:listNotificationInterests()

	local observer
	if #interests > 0 then
		observer = kode.observer:extend{
			notify = "handleNotification",
			context = controller
		}
		for i=1, #interests do
			self:registerObserver(interests[i], observer)
		end
	end
	-- local util = require "kodelua.util"
	-- util.Dump(self.observerMap)
	controller:onRegister()
end

function kode.facade:retrieveController(controllerName)
	return self.controllerMap[controllerName]
end

function kode.facade:hasController(controllerName)
	return self.controllerMap[controllerName] ~= nil
end

function kode.facade:removeController(controllerName)
	local controller = self.controllerMap[controllerName]
	if controller then
		local interests = controller:listNotificationInterests()
		for i=1, #interests do
			self:removeObserver(interests[i], controller)
		end

		controller.onRemove()
		self.controllerMap[controllerName] = nil
	end
end