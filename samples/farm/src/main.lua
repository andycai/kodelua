require "Cocos2d"
require "Cocos2dConstants"

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

local function main()
	cc.FileUtils:getInstance():addSearchPath("src")
	cc.FileUtils:getInstance():addSearchPath("res")
	
	require "kode.init"		-- framework
	require "app.init"			-- app
end

xpcall(main, __G__TRACKBACK__)