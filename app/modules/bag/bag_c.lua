require "kode.helpers.csv"

local bagController = BaseController:extend{
	name = "bagController2013-1-10";
}
local meta = bagController

local bagService = loadService("bag")

function meta:onRegister()
	-- body
end

function meta:listNotificationInterests()
	return {
		Event.EVENT_START_APP,
		Event.EVENT_BAG_GET_SIZE
	}
end

--[[
private action method
--]]

function meta:action_app_start_()
	puts("app start")
	local nums, data, labels = kode.loadcsv("./doc/player.csv")
	puts(kode.__("Testing %s", "bagController"))
	puts(data)
	bagService:reqBagGetSize()
end

function meta:action_bag_get_size_(param)
	puts(param)
end

return meta