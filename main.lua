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
	xpcall(function()
		if response then
			log4j.Debug(response)
		end
	end, __G__TRACKBACK__)
end

local function main()
	require "kodelua.init"
	require "init"
	-- register controllers
	require "register"

	local bagService = require "serv.bag"
	bagService:reqBagGet()
	bagService:onBagGet({})
end

xpcall(main, __G__TRACKBACK__)