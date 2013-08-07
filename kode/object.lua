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

--[[ 
--sample:

local base = meta:extend()

base.key1 = "base.key1"
base.key2 = "base.key2"

local a = base:extend({})
local b = base:extend({})
local c = base:extend({})

a.key1 = "a.key1"
b.key1 = "b.key1"
c.key1 = "c.key1"

print("base.key1: " .. base["key1"])
print("base.key2: " .. base["key2"])

print("a.key1: " .. a["key1"])
print("b.key1: " .. b["key1"])
print("c.key1: " .. c["key1"])

print("a.key2: " .. a["key2"])
print("b.key2: " .. b["key2"])
print("c.key2: " .. c["key2"])
--]]