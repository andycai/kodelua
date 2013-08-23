if kode == nil then return end

-- {nil}; required
local controllers = {
	{ctrl=require "app.controller.bag"; view=require "app.view.bag.bagpane"};
	{nil};
}

for i,v in ipairs(controllers) do
	if v and v.ctrl and v.view then
		appFacade:register(v.ctrl, v.view)
	end
	-- appFacade:RemoveController(v.ctrl.name)
end