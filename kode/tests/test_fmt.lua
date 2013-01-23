(function(...)
	args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end)("../")

require "lunit"

local fmt = require "kode.helpers.fmt"

module(..., package.seeall, lunit.testcase)

function test_Sprintf()
	local format = "format %s: %0.2f"
	local num = 654.978043234234
	local result = kode.fmt.sprintf(format, "number", num)
	assert_equal(result, "format number: 654.98")
end