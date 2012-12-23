local Object = require "cola.object".Class
local Notifier = require "cola.mvc.notifier".Class

module(...)

local Actor = Object:extend()
Class = Actor

function Actor:Dispatch(eventObj)
	Notifier:Dispatch(eventObj)
end

function Actor:AddListener(name, handler)
	Notifier:AddListener(name, handler)
end

function Actor:RemoveListener(name, handler)
	Notifier:RemoveListener(name, handler)
end