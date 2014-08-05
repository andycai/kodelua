if kode == nil then return end

Event.EVENT_MODULE_GET_SOMETHING = "module_get_something"

Event.register("{{name}}", function() return
	{
		Event.EVENT_MODULE_GET_SOMETHING,
		"EOF"
	}
	end
)