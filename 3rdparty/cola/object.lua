local setmetatable = setmetatable

module(...)

local Object = {
	name = "object"
}
Class = Object

function Object:Extend(class)
	class = class or {}
	setmetatable(class, self)
	self.__index = self

	return class
end

Object.New = Object.Extend