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

Object = require "kodelua.object"
KFacade = require "kodelua.mvc.facade"
KNotifier = require "kodelua.mvc.notifier"
KObserver = require "kodelua.mvc.observer"
KNotification = require "kodelua.mvc.notification"
KController = require "kodelua.mvc.controller"

strings = require "kodelua.strings"
map = require "kodelua.map"
util = require "kodelua.util"
fmt = require "kodelua.fmt"
say = require "kodelua.i18n"
log4j = require "kodelua.log4j"
csv = require "kodelua.csv"

-- avoid memory leak
collectgarbage("setpause", 100)
collectgarbage("setstepmul", 5000)