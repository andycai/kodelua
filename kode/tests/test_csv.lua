(function(...)
	args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end)("../")

require "lunit"

local csv = require "kode.helpers.csv"

module(..., package.seeall, lunit.testcase)

function test_load()
	nums, data, labels = kode.csv.load("../kode/tests/player.csv")

	assert_equal(nums, 3)
	assert_equal(labels[1], "name")
	assert_equal(labels[2], "sex")
	assert_equal(labels[3], "age")
	assert_equal(data[1][1], "Andy")
	assert_equal(data[1][2], "male")
	assert_equal(data[1][3], "18")
	assert_equal(data[2][1], "Nataly")
	assert_equal(data[2][2], "female")
	assert_equal(data[2][3], "18")
	assert_equal(data[3][1], "Peter")
	assert_equal(data[3][2], "male")
	assert_equal(data[3][3], "20")
end