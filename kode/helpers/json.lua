local encode, decode
local ok

if ENVIRONMENT__ == "product" then
	ok = pcall(function()
		local cjson = require "cjson"
		encode = cjson.encode
		decode = cjson.decode
	end)
end

if not ok then
	local simplejson = require "kode.helpers.simplejson"
	encode = simplejson.encode
	decode = simplejson.decode
end

kode.json = {}

function kode.json.encode(tbl)
	local ok, result = pcall(encode, tbl)

	if ok then return result end
	error("json encode failed")
end

function kode.json.decode(str)
	local ok, result = pcall(decode, str)

	if ok then return result end
	error("json decode failed")
end