kode = kode or {}

require "kode.helpers.var"
require "kode.helpers.i18n"

kode.namespace = {}
kode.ns = kode.namespace

local packages_ = {}

kode.import = function(name)
	local p
	if packages_[name] then
		p = packages_[name]
	else
		p = require(name)
		packages_[name] = p
	end
	return p
end

kode.register_namespace = function(nsdata)
	local obj
	if istable(nsdata) and isset(nsdata.namespace) then
		kode.namespace[nsdata.namespace] = {}
		obj = kode.namespace[nsdata.namespace]
	else
		obj = kode.namespace
	end

	for name, path in pairs(nsdata.modules) do
		obj[name] = {}
		local callback = nsdata.methods[name]

		local mt_ = {}
		mt_.__index = function(table, key)
			if isfunction(callback) then
				return callback(key, path)
			else
				return kode.import(path..key)
			end
		end
		setmetatable(obj[name], mt_)
	end
end

function kode.tostring(obj, ...)
	if type(obj) == "table" then
		return table.tostring(obj)
	end

	if ... then
		obj = string.format(tostring(obj), ...)
	else
		obj = tostring(obj)
	end

	return obj
end

function sputs(obj, ...)
	if type(obj) == "table" then
		obj = kode.tostring(obj)
	else
		if type(obj)=="string" and string.indexOf(obj, "%%s") ~= -1 then
			if ... then
				obj = obj:format(...)
			end
		else
			obj = kode.tostring(obj)
			if ... then
				local len = select("#", ...)
				for i=1,len do
					obj = string.format("%s %s", obj, kode.tostring(select(i, ...)))
				end
			end
		end
	end
	return obj
end

function puts(obj, ...)
	print(sputs(obj, ...))
end

function kode.appendPath(...)
	local args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end

-- Function string.gfind was renamed string.gmatch. (Option LUA_COMPAT_GFIND) 
function kode.getglobal(f)
	local v = _G
	-- for w in string.gfind(f, "[%w_]") do
	for w in string.gmatch(f, "[%w_]+") do
		v = v[w]
	end
	return v
end

function kode.setglobal(f, v)
	local t = _G
	-- for w, d in string.gfind(f, "([%w_]+)(.?)") do
	for w, d in string.gmatch(f, "([%w_]+)(.?)") do
		if d == "." then -- not last field
			t[w] = t[w] or {}	-- create table if absent
			t = t[w]			-- get the table
		else					-- last field
			t[w] = v 			-- do the assignment
		end
	end
end

function kode.vardump(...)
	local count = select("#", ...)
	if count < 1 then return end

	print("vardump:")
	for i = 1, count do
		local v = select(i, ...)
		local t = type(v)
		if t == "string" then
			print(string.format("  %02d: [string] %s", i, v))
		elseif t == "boolean" then
			print(string.format("  %02d: [boolean] %s", i, tostring(v)))
		elseif t == "number" then
			print(string.format("  %02d: [number] %0.2f", i, v))
		else
			print(string.format("  %02d: [%s] %s", i, t, tostring(v)))
		end
	end
end

function kode.eval(input)
	return pcall(function()
		if not input:match("=") then
			input = "do return (" .. input .. ") end"
		end

		local code, err = loadstring(input, "REPL")
		if err then
			error("Syntax Error: " .. err)
		else
			print(code())
		end
	end)
end

function kode.escape(s)
	if s == nil then return '' end
	local esc, i = s:gsub('&', '&amp'):gsub('<', '&lt'):gsub('>', '&gt')

	return esc
end

function kode.urlencode(s)
	return s:gsub("\n", "\r\n"):gsub("([^%-%-%/]", 
		function(c) return ("%%%02X"):format(string.byte(c))
	end)
end

function kode.clone(object)
	local lookup_table = {}
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end
		local new_table = {}
		lookup_table[object] = new_table
		for key, value in pairs(object) do
			new_table[_copy(key)] = _copy(value)
		end
		return setmetatable(new_table, getmetatable(object))
	end
	return _copy(object)
end

--Create an class.
function kode.class(classname, super)
	local superType = type(super)
	local cls

	if superType ~= "function" and superType ~= "table" then
		superType = nil
		super = nil
	end

	if superType == "function" or (super and super.__ctype == 1) then
		-- inherited from native C++ Object
		cls = {}

		if superType == "table" then
			-- copy fields from super
			for k,v in pairs(super) do cls[k] = v end
			cls.__create = super.__create
			cls.super    = super
		else
			cls.__create = super
		end

		cls.ctor    = function() end
		cls.__cname = classname
		cls.__ctype = 1

		function cls.new(...)
			local instance = cls.__create(...)
			-- copy fields from class to native object
			for k,v in pairs(cls) do instance[k] = v end
			instance.class = cls
			instance:ctor(...)
			return instance
		end

	else
		-- inherited from Lua Object
		if super then
			cls = kode.clone(super)
			cls.super = super
		else
			cls = {ctor = function() end}
		end

		cls.__cname = classname
		cls.__ctype = 2 -- lua
		cls.__index = cls

		function cls.new(...)
			local instance = setmetatable({}, cls)
			instance.class = cls
			instance:ctor(...)
			return instance
		end
	end

	return cls
end