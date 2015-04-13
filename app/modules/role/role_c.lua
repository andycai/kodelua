if kode == nil then return end

require "kode.helpers.csv"

local roleController = BaseController:extend{
	name = "roleController2013-1-10";
}
local meta = roleController

function meta:onRegister()
	-- body
end

--[[
private action method
--]]

function meta:action_app_start_()
	puts("app start")
	local nums, data, labels = kode.loadcsv("./doc/player.csv")
	puts(kode.__("Testing %s", "roleController"))
	puts("csv data:", data)

	local roleService = ns.service.role
	roleService:reqBagGetSize()

	local roleModle = ns.model.role_hero
	local size_ = roleModel:getBagSize()
	puts("role model: get bag size: %s", size_)

	local rolePane = ns.view.role
	rolePane:hello()

	local heroPane = ns.view.role_heropane
	heroPane:hello()
end

function meta:action_bag_get_size_(param)
	puts("role bag info:", param)
end

return meta