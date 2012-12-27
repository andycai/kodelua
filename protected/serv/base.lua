local baseService = KNotifier:Extend{
	Name = "BaseService"
}

function baseService:Request(action, param)
	local p = {
		act = action;
		param = param
	}
	-- request to network with c++ interface
end

-- function baseService:Notify(name, data)
-- 	local d = data or {}
-- 	d.name = name

-- 	self:Dispatch(d)
-- end

return baseService