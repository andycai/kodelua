local Object = require "kodelua.object"

local Notifier = Object:Extend{
	Name = "Notifier"
}

if Notifier.listeners == nil then
	Notifier.listeners = {}
	Notifier.count = 0
end

function Notifier:Dispatch(eventObj)
	local i = 1

	while self.listeners[i] do
		local  obj = self.listeners[i]

		if obj.name == eventObj.name then
			if type(obj.listener) == "function" then

				local util = require "kodelua.util"
				util.Dump(eventObj)
				obj.listener(obj, eventObj)
			elseif type(obj.listener) == "table" then
				obj.listener[obj.name](self, eventObj)
			end
		end
		i = i + 1
	end
	return true
end

function Notifier:AddListener(name, listener)
	if name == nil then error("Notifier::AddListener, name is nil.") end
	if listener == nil then error("Notifier::AddListener, listener is nil.") end
	if self:HasListener(name, listener) == false then
		self.count = self.count + 1
		op = table.insert(self.listeners, {listener=listener, name=name, count=self.count})
		return op
	else
		return false
	end
end

function Notifier:RemoveListener(name, listener)
	local i = 1
	while self.listeners[i] do
		local obj = self.listeners[i]
		
		if obj.name == name and obj.listener == handler then
			self.count =self.count + 1
			table.remove(self.listeners, i)
		else
			i = i + 1
		end
	end
	return true
end

function Notifier:HasListener(name, handler)
	assert(name ~= nil, "Notifier:HasListener, name is nil")
	assert(handler ~= nil, "Notifier:HasListener, handler is nil")
	
	for i, obj in ipairs(self.listeners) do
		if obj.name == name and obj.listener == handler then
			return true, i
		end
	end
	return false
end

return Notifier