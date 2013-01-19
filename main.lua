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
			local resp = kode.json.decode(response)
			local act = string.explode(resp.act, ".")
			local service = kode.getglobal(act[1].."Service")
			local action = act[2]
			if service ~= nil then
				if service[action] then
					service[action](service, resp.param)
				else
					log4l.debug("need a function [%s] in service [%s]", action, act[1])
				end
			else
				log4l.debug("Wrong aciton: %s", response)
			end
		end
	end, __G__TRACKBACK__)
end

local function main()
	require "kode.init"		-- framework
	require "init"			-- app
	require "register" 		-- register controllers
	require "appfacade"		-- application

	appFacade:startup()		-- startup
end

xpcall(main, __G__TRACKBACK__)