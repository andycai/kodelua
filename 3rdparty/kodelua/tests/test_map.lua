(function(...)
	args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end)("../")

require "lunit"

local map = require "kodelua.map"

module(..., package.seeall, lunit.testcase)

function test_Haskey()
	local tbl = {name="andy", age=18}
	assert_true(map.Haskey(tbl, "name"), "there is a key name in table tbl.")
	assert_false(map.Haskey(tbl, "sex"), "there is not a key sex in table tbl.")
end

function test_Keys()
	local tbl = {name="andy", age=18}
	local keys = map.Keys(tbl)
	assert_equal(keys[1], "name")
	assert_equal(keys[2], "age")
end

function test_Values()
	local tbl = {name="andy", age=18}
	local values = map.Values(tbl)
	assert_equal(values[1], "andy")
	assert_equal(values[2], 18)
end

function test_Len()
	local tbl = {name="andy", age=18}
	assert_equal(map.Len(tbl), 2)
end

function test_Tostring()
	local tbl = {name="andy", age=18}
	assert_equal(map.Tostring(tbl), [[name = "andy"
age = "18"
]])
end

function test_Update()
	local tbl = {name="andy"}
	local tbl2 = {age=18}
	map.Update(tbl, tbl2)
	assert_equal(tbl["age"], 18)
end

function test_Clone()
	local tbl = {name="andy"}
	local tbl2 = map.Clone(tbl)
	assert_equal(tbl["name"], tbl2["name"])
	assert_not_equal(tbl, tbl2)
end

function test_TablePrint()
end

function test_TableConcat()
	local tbl = {name="andy", {age=18}, "hello"}
	local str = map.TableConcat(tbl)
	assert_equal(str, "18helloandy")
end