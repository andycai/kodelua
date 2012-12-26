local Actor = require "kodelua.mvc.actor"
local Notifier = require "kodelua.mvc.notifier"

local Controller = Actor:Extend{
	Name = "Controller";
	viewInstance = {}
}

function Controller:New(viewInstance)
	assert(self.viewInstance ~= nil, "need a viewInstance")
	self.viewInstance = viewInstance

	o = {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function Controller:onRegister()
end

function Controller:onRemove()
end

function Controller:destroy()
	self.viewInstance = nil
end

function Controller:AddListener(name, handler)
	Notifier:AddListener(name, handler)
end

function Controller:RemoveListener(name, handler)
	Notifier:RemoveListener(name, handler)
end

return Controller