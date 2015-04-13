kode = kode or {}

local registry = { }
local current_namespace
local fallback_namespace

local unpack = unpack
if table.unpack then
	unpack = table.unpack
end

local text = {
	setnamespace = function(self, namespace)
		current_namespace = namespace
		if not registry[current_namespace] then
			registry[current_namespace] = {}
		end
	end;

	setfallback = function(self, namespace)
		fallback_namespace = namespace
		if not registry[fallback_namespace] then
			registry[fallback_namespace] = {}
		end
	end;

	set = function(self, key, value)
		registry[current_namespace][key] = value
	end
}

local __meta = {
	__call = function(self, key, ...)
		vars = {...}

		local str = registry[current_namespace][key] or registry[fallback_namespace][key]

		if str == nil then
			str = key
			if self.hook then
				self.hook(str)
			end
		end
		str = tostring(str)
		local strings = {}

		for i,v in ipairs(vars) do
			table.insert(strings, tostring(v))
		end

		return #strings > 0 and str:format(unpack(strings)) or str
	end;

	__index = function(self, key)
		return registry[key]
	end
}

text:setfallback('zh')
text:setnamespace('zh')

kode.__ = setmetatable(text, __meta)
kode.text = kode.__

--[==[
Usage:

local text = kode.text
-- local text = require "kode.text"

text:setnamespace("en")

text:set('money', 'I have %s dollars')
text:set('wow', 'So much money!')

print(s('money', 1000)) -- I have 1000 dollars

text:setnamespace("fr") -- switch to french!
text:set('wow', "Tant d'argent!")

print(s('wow')) -- Tant d'argent!
text:setnamespace("en")  -- switch back to english!
print(s('wow')) -- So much money!

--]==]