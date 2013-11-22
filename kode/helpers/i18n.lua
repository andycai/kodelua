local registry = { }
local current_namespace
local fallback_namespace

local unpack = unpack
if table.unpack then
	unpack = table.unpack
end

local s = {
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

s:setfallback('zh')
s:setnamespace('zh')

kode.i18n = setmetatable(s, __meta)

return kode.i18n

--[==[
Usage:

s = require "kode.i18n"

s:setnamespace("en")

s:set('money', 'I have %s dollars')
s:set('wow', 'So much money!')

print(s('money', 1000)) -- I have 1000 dollars

s:setnamespace("fr") -- switch to french!
s:set('wow', "Tant d'argent!")

print(s('wow')) -- Tant d'argent!
s:setnamespace("en")  -- switch back to english!
print(s('wow')) -- So much money!

--]==]