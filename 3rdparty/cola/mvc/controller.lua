local Actor = require "cola.mvc.actor".Class

module(...)

local Controller = Actor.Extend{
	viewInstance = {}
}
Class = Controller

function Controller:New(viewInstance)
	assert(viewInstance ~= nil, "need a viewInstance")
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