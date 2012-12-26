(function(...)
	args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end)("./3rdparty/")

-- require "register"
local csv = require "kodelua.csv"
local util = require "kodelua.util"
-- local Context = require "kodelua.mvcs.context"

local bagService = require "service.bagservice"
local bagCtrl = require "controller.bagcontroller"
local bagPane = require "view.bag.bagpane"
local appFacade = require "appfacade"

local function main()
	nums, data, labels = csv.LoadAndSave("./3rdparty/kodelua/tests/player.csv")
	-- print("Player data rows: ", nums)
	-- util.Dump(labels, "Label")
	-- util.Dump(data, "Player Data")

	-- Context:Initialize()
	appFacade:Register(bagCtrl, bagPane)

	bagService:reqBagGet()
	bagService:onBagGet({})

	appFacade:RemoveController(bagCtrl.name)

end

-- response string
function Route(response)
	-- body
end

function errHandler()
	debug.traceback()
end

xpcall(main, errHandler)