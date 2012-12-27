local Object = require "kodelua.object"
local Notification = require "kodelua.mvc.notification"
local Observer = require "kodelua.mvc.observer"
local log4j = require "kodelua.log4j"

local Facade = Object:Extend{
	observerMap = {};
	controllerMap = {}
}

function Facade:New()
	log4j.Error("Singleton cannot be instantiated.")
end

function Facade:registerObserver(notificationName, observer)
	if self.observerMap[notificationName] == nil then
		self.observerMap[notificationName] = {observer}
	else
		table.insert(self.observerMap[notificationName], observer)
	end
end

function Facade:notifyObservers(notification)
	local observers
	local observer
	if self.observerMap[notification.name] then
		observers = self.observerMap[notification.name]
		for i=1, #observers do
			observer = observers[i]
			observer:NotifyObserver(notification)
		end
	end
end

function Facade:removeObserver(notificationName, notifyContext)
	local observers = self.observerMap[notificationName]
	if observers == nil or type(observers) ~= "table" then return end
	for i=1, #observers do
		if observers[i] and observers[i]:CompareNotifyContext(notifyContext) then
			log4j.Info("Removed Observer notification: %s", notificationName)
			table.remove(observers, i)
			break
		end
	end
	if #observers == 0 then
		self.observerMap[notificationName] = nil
	end

end

function Facade:SendNotification(name, body, kind)
	log4j.Info("SendNotification: name=%s, kind=%s", name, kind)
	self:notifyObservers(Notification:Extend{name=name, body=body, kind=kind})
end

function Facade:RegisterController(controller)
	if self.controllerMap[controller.name] ~= nil then return end

	self.controllerMap[controller.name] = controller
	local interests = controller:ListNotificationInterests()

	local observer
	if #interests > 0 then
		observer = Observer:Extend{
			notify = "HandleNotification",
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

function Facade:RetrieveController(controllerName)
	return self.controllerMap[controllerName]
end

function Facade:HasController(controllerName)
	return self.controllerMap[controllerName] ~= nil
end

function Facade:RemoveController(controllerName)
	local controller = self.controllerMap[controllerName]
	if controller then
		local interests = controller:ListNotificationInterests()
		for i=1, #interests do
			self:removeObserver(interests[i], controller)
		end

		controller.onRemove()
		self.controllerMap[controllerName] = nil
	end
end

return Facade