local bagService = KService:Extend()

function bagService:reqBagGet()
	log4j.Debug("Request getting bag infomation")
	self.action = "bag.get"
	self.param = {}
	self:Request()
end
function bagService:onBagGet(param)
	-- save to model
	-- send notice
	self:Notify(roleModel.EVENT_BAG_GET, {1, 3, 5}, "common notice")
end

return bagService
