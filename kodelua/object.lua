local object
object = {
	Name = "object"
}

function object:Extend(class)
	class = class or {}
	setmetatable(class, self)
	self.__index = self

	return class
end

object.New = object.Extend

return object