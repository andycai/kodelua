(function(...)
	args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end)("./protected/")

local log4j = require "kodelua.log4j"

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

-- public interface for C++
-- response: may be a json string or other you want
-- parse reponse and dispatch to real module
function Route(response)
	log4j.Debug(response)
end

local function main()
	-- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

	-- register controllers
	require "register"

	local bagService = require "serv.bag"
	bagService:reqBagGet()
	bagService:onBagGet({})
end

xpcall(main, __G__TRACKBACK__)