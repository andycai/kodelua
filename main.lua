-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

local function main()
	require "kode.init"		-- framework

    kode.appendPackagePath("./protected/") -- append app directory to package path

	require "init"			-- app
	require "appfacade"		-- application
    require "register"      -- register controllers

	appFacade:startup()		-- startup
end

xpcall(main, __G__TRACKBACK__)