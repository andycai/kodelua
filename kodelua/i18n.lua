--[==[
s = require "kodelua.i18n"

s:SetNamespace("en")

s:Set('money', 'I have %s dollars')
s:Set('wow', 'So much money!')

print(s('money', 1000)) -- I have 1000 dollars

s:SetNamespace("fr") -- switch to french!
s:Set('wow', "Tant d'argent!")

print(s('wow')) -- Tant d'argent!
s:SetNamespace("en")  -- switch back to english!
print(s('wow')) -- So much money!
--]==]

local registry = { }
local current_namespace
local fallback_namespace

local s = {
	SetNamespace = function(self, namespace)
		current_namespace = namespace
		if not registry[current_namespace] then
			registry[current_namespace] = {}
		end
	end;

	SetFallback = function(self, namespace)
		fallback_namespace = namespace
		if not registry[fallback_namespace] then
			registry[fallback_namespace] = {}
		end
	end;

	Set = function(self, key, value)
		registry[current_namespace][key] = value
	end
}

local __meta = {
	__call = function(self, key, ...)
		vars = {...}

		local str = registry[current_namespace][key] or registry[fallback_namespace][key]

		if str == nil then
			return nil
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

s:SetFallback('zh')
s:SetNamespace('zh')

return setmetatable(s, __meta)