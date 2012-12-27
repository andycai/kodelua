local encode, decode
local ok

if __FRAMEWORK_ENVIRONMENT__ == "product" then
	ok = pcall(function()
		local cjson = require "cjson"
		encode = cjson.encode
		decode = cjson.decode
	end)
end

if not ok then
	local simplejson = require "kodelua.encoding.simplejson"
	encode = simplejson.encode
	decode = simplejson.decode
end

local json
json = {}

function json.Encode(tbl)
	local ok, result = pcall(encode, tbl)

	if ok then return result end
	error("json encode failed")
end

function json.Decode(str)
	local ok, result = pcall(decode, str)

	if ok then return result end
	error("json decode failed")
end

return json