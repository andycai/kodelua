kode = {}
using = {}

function kode.appendPackagePath(...)
	local args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end
--kode.appendPackagePath("./")

require "kode.object"
require "kode.ext.init"
require "kode.helpers.init"
require "kode.mvc.init"

-- avoid memory leak
collectgarbage("setpause", 100)
collectgarbage("setstepmul", 5000)