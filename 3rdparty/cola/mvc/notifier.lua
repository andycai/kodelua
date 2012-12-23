local Object = require "cola.object".Class
local type, table, error, assert, ipairs = type, table, error, assert, ipairs

module(...)

local Notifier = {}
Class = Notifier

if Notifier.Listeners == nil then
	Notifier.Listeners = {}
	Notifier.count = 0
end

function Notifier:Dispatch(eventObj)
	local i = 1

	while Notifier.Listeners[i] do
		local  obj = Notifier.Listeners[i]

		if obj.name == eventObj.name then
			if type(obj.listener) == "function" then
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
	if Notifier:HasListener(name, listener) == false then
		Notifier.count = Notifier.count + 1
		return table.insert(Notifier.Listeners, {listener=listener, name=name, count=Notifier.count})
	else
		return false
	end	
end

function Notifier:RemoveListener(name, listener)
	local i = 1
	while Notifier.Listeners[i] do
		local obj = Notifier.Listeners[i]
		
		if obj.name == name and obj.listener == handler then
			Notifier.count =Notifier.count + 1
			table.remove(Notifier.Listeners, i)
		else
			i = i + 1
		end
	end
	return true
end

function Notifier:HasListener(name, handler)
	assert(name ~= nil, "Notifier:HasListener, name is nil")
	assert(handler ~= nil, "Notifier:HasListener, handler is nil")
	
	for i, obj in ipairs(Notifier.Listeners) do
		if obj.name == name and obj.listener == handler then
			return true, i
		end
	end
	return false
end