local bagService = BaseService:extend()
local meta = bagService

function meta:reqBagGet()
	log4l.debug("Request getting bag infomation")
	self.action = "bag.get"
	self.param = {}
	self:request()
end
function meta:onBagGet(param)
	-- save to model
	-- send notice
	self:notify(bagModel.EVENT_BAG_GET, {1, 3, 5}, "common notice")
end

return meta
