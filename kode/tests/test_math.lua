(function(...)
	args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end)("../")

require "lunit"

local maths = require "kode.ext.math"

module(..., package.seeall, lunit.testcase)

function test_round()
	local num = 123.43234234
	local num2 = 654.978043234234
	assert_equal(math.round(num), 123)
	assert_equal(math.round(num*100)/100, 123.43)
	assert_equal(math.round(num2), 655)
	assert_equal(math.round(num2*100)/100, 654.98)
end