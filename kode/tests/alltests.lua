(function(...)
	args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end)("../")

require "lunit"

require "kodelua.tests.test_math"
require "kodelua.tests.test_string"
require "kodelua.tests.test_i18n"
require "kodelua.tests.test_csv"
require "kodelua.tests.test_fmt"