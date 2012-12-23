(function(...)
	args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end)("./thirdparty/")

csv = require "cola.csv"
util = require "cola.util"

nums, data, labels = csv.LoadAndSave("./thirdparty/cola/tests/player.csv")

util.Dump(data)
print(nums)