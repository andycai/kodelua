if kode == nil then return end

require "kode.helpers.json"

local roleService = BaseService:extend()
local meta = roleService

function meta:reqBagGetSize()
	print("role service: request getting bag size")
	self.action = "bag.getsize"
	self.param = {}
	self:request()

	self:onBagGetSize()
end

function meta:onBagGetSize(param)
	-- save to model
	-- send notice
	puts("role service: onBagGetSize")
	local roleModel = ns.model.role
	roleModel:setBagSize(32)
	self:send(Event.EVENT_BAG_GET_SIZE, {size=32}, "role_bag")
end

return meta
