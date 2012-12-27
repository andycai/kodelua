local bagModel = require "model.bag"

local bagService = KService:Extend()

function bagService:reqBagGet()
	log4j.Debug("Request getting bag infomation")
end

function bagService:onBagGet(param)
	-- save to model
	-- send notice
	self:Notify(bagModel.EVENT_BAG_GET, {1, 3, 5}, "common notice")
end

return bagService
