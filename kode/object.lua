local meta = {
	name = "object"
}

function meta:extend(class)
	class = class or {}
	setmetatable(class, self)
	self.__index = self

	return class
end

meta.new = meta.extend

kode.object = meta