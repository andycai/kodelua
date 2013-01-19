kode = {}

function kode.appendPkgPath(...)
	local args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end
kode.appendPkgPath("./", "./protected/")

__FRAMEWORK_ENVIRONMENT__ = "unknown"

require "kode.object"
require "kode.ext"
require "kode.helpers"
require "kode.mvc"

-- avoid memory leak
collectgarbage("setpause", 100)
collectgarbage("setstepmul", 5000)