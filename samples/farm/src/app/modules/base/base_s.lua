local baseService = kode.notifier:extend{
	name = "BaseService";
	action = "";
	param = {}
}

function baseService:request()
	local requestString = kode.json.encode({act=self.action; param=self.param})
	requestServer(requestString)
end

return baseService