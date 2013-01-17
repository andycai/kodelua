function AppendPkgPath(...)
	local args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end
AppendPkgPath("./protected/")

function Getglobal(f)
    local v = _G      -- start with the table of globals
    for w in string.gfind(f, "[%w_]+") do
       v = v[w]
    end
    return v
end

function Setglobal(f, v)
    local t = _G         -- start with the table of globals
    for w, d in string.gfind(f, "([%w_]+)(.?)") do
       if d == "." then  -- not last field?
           t[w] = t[w] or {}    -- create table if absent
           t = t[w]          -- get the table
       else                 -- last field
           t[w] = v          -- do the assignment
       end
    end
end

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
json = require "kodelua.encoding.json"

--
lhelper=require "kodelua.luahelper"
-- avoid memory leak
collectgarbage("setpause", 100)
collectgarbage("setstepmul", 5000)