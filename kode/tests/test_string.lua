-- 将自定义包路径加入package的搜索路径中。也可以加到环境变量LUA_PATH中
(function(...)
	args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end)("../")

require "lunit"

local strings = require "kode.ext.string"

module(..., package.seeall, lunit.testcase)

function test_split()
	local str = "a, b, c, d"
	local tbl = string.split(str, ",")
	assert_equal(tbl[1], "a")
	assert_not_equal(tbl[2], "b")
	assert_not_equal(tbl[3], "c")
end

function test_explode()
	local str = "a, b, c, d"
	local tbl = string.explode(str, ",")
	assert_equal(tbl[1], "a")
	assert_not_equal(tbl[2], "b")
	assert_not_equal(tbl[3], "c")
end