require "kode.helpers.json"

local bagService = BaseService:extend()
local meta = bagService

local bagModel = loadModel("bag")

function meta:reqBagGetSize()
	print("Request getting bag size")
	self.action = "bag.getsize"
	self.param = {}
	self:request()

	self:onBagGetSize()
end
function meta:onBagGetSize(param)
	-- save to model
	-- send notice
	puts("onBagGetSize")
	self:send(Event.EVENT_BAG_GET_SIZE, {size=32}, "role_bag")
end

return meta
