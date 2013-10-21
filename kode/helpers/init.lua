require "kode.helpers.fmt"
require "kode.helpers.csv"
require "kode.helpers.log4l"
require "kode.helpers.i18n"
require "kode.helpers.json"
require "kode.helpers.ioutil"
require "kode.helpers.callback"
require "kode.helpers.base64"
require "kode.helpers.time"

-- Just a bunch of global helper functions

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

function puts(obj, ...)
 	print(kode.tostring(obj, ...))
end

function istrue(value)
	if value ~= false and value ~= nil then
		return true
	end
	return false
end

function isempty(t, key)
	return (not t[key])
end

function checkvalue(value, msg)
	if not msg then msg = "value is nil" end
	if not value then
		error(msg)
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

function kode.dump(obj, ...)
	puts(obj, ...)
end

function kode.vardump(...)
	local count = select("#", ...)
	if count < 1 then return end

	puts("vardump:")
	for i = 1, count do
		local v = select(i, ...)
		local t = type(v)
		if t == "string" then
			puts("  %02d: [string] %s", i, v)
		elseif t == "boolean" then
			puts("  %02d: [boolean] %s", i, tostring(v))
		elseif t == "number" then
			puts("  %02d: [number] %0.2f", i, v)
		else
			puts("  %02d: [%s] %s", i, t, tostring(v))
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
			puts(code())
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