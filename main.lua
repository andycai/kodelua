(function(...)
	args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end)("./3rdparty/")

local log4j = require "kodelua.log4j"

local function main()
	-- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    -- test for reading csv data
    local util = require "kodelua.util"
	local csv = require "kodelua.csv"
	nums, data, labels = csv.LoadAndSave("./3rdparty/kodelua/tests/player.csv")
	print("Player data rows: ", nums)
	util.Dump(labels, "Label")
	util.Dump(data, "Player Data")

	-- register controller
	-- require "register"
	local appFacade = require "appfacade"
	local bagCtrl = require "controller.bagcontroller"
	local bagPane = require "view.bag.bagpane"
	appFacade:Register(bagCtrl, bagPane)

	local bagService = require "service.bagservice"
	bagService:reqBagGet()
	bagService:onBagGet({})
	appFacade:RemoveController(bagCtrl.name)
end

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

xpcall(main, __G__TRACKBACK__)