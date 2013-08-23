local baseService = kode.notifier:extend{
	name = "BaseService";
	action = "";
	param = {}
}

function baseService:request()
	-- request to network with c++ interface "RequestServer"
	local requestString = kode.json.encode({act=self.action; param=self.param})
	RequestServer(requestString)
end

return baseService