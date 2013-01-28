if kode == nil then return end

local controllers = {
	{ctrl=require "controller.bag"; view=require "view.bag.bagpane"};
}

for i,v in ipairs(controllers) do
	appFacade:register(v.ctrl, v.view)
	-- appFacade:RemoveController(v.ctrl.name)
end