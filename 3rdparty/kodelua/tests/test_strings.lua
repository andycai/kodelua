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

local strings = require "kodelua.strings"

module(..., package.seeall, lunit.testcase)

function test_Split()
	local str = "a, b, c, d"
	local tbl = strings.Split(str, ",")
	assert_equal(tbl[1], "a")
	assert_not_equal(tbl[2], "b")
	assert_not_equal(tbl[3], "c")
end

function test_Explode()
	local str = "a, b, c, d"
	local tbl = strings.Explode(str, ",")
	assert_equal(tbl[1], "a")
	assert_not_equal(tbl[2], "b")
	assert_not_equal(tbl[3], "c")
end

function test_PushBuffer()
	local str = "a, b, c, d"
	local tbl = {}
	strings.PushBuffer(tbl, str)
	assert_equal(tbl[1], "a, b, c, d")
end

function test_PullBuffer()
	local tbl = {"a", "b", "c", "d"}
	local str = strings.PullBuffer(tbl)
	assert_equal(str, "abcd")
end