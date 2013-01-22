-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

local function main()
	require "kode.init"		-- framework
	require "init"			-- app
	require "register" 		-- register controllers
	require "appfacade"		-- application

	appFacade:startup()		-- startup
end

xpcall(main, __G__TRACKBACK__)