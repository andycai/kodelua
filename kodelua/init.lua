function AppendPkgPath(...)
	local args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end
AppendPkgPath("./protected/")

__FRAMEWORK_ENVIRONMENT__ = "unknown"

strings = require "kodelua.strings"
map = require "kodelua.map"
util = require "kodelua.util"
fmt = require "kodelua.fmt"
say = require "kodelua.i18n"
log4j = require "kodelua.log4j"
csv = require "kodelua.csv"

KController = require "kodelua.mvc.controller"
KActor = require "kodelua.mvc.notifier"

-- avoid memory leak
collectgarbage("setpause", 100)
collectgarbage("setstepmul", 5000)