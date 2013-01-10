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
			local resp = json.Decode(response)
			local act = strings.Explode(resp.act, ".")
			local service = Getglobal(act[1].."Service")
			local action = act[2]
			if service ~= nil then
				service[action](service, resp.param)
			else
				log4j.Debug("Wrong aciton: %s", response)
			end
		end
	end, __G__TRACKBACK__)
end

local function main()
	require "kodelua.init"
	require "init"
	-- register controllers
	require "register"

	-- login
	roleService:reqOnline()
end

xpcall(main, __G__TRACKBACK__)