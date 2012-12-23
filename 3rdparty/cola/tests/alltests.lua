(function(...)
	args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end)("../")

require "lunit"

local csv = require "cola.csv"

require "cola.tests.test_math"
require "cola.tests.test_strings"
require "cola.tests.test_i18n"
require "cola.tests.test_csv"
require "cola.tests.test_map"