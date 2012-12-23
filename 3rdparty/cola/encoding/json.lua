local encode, decode
local ok

if __FRAMEWORK_ENVIRONMENT__ == "client" then
	ok = pcall(function()
		local cjson = require "cjson"
		encode = cjson.encode
		decode = cjson.decode
	end)
end

if not ok then
	print("using simplejson")
	local simplejson = require "cola.encoding.simplejson"
	encode = simplejson.encode
	decode = simplejson.decode
end

local pcall, error = pcall, error

module(...)

function Encode(tbl)
	local ok, result = pcall(encode, tbl)

	if ok then return result end
	error("json encode failed")
end

function Decode(str)
	local ok, result = pcall(decode, str)

	if ok then return result end
	error("json decode failed")
end