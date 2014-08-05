if kode == nil then return end

Event.EVENT_MODULE_GET_SOMETHING = "module_get_something"

Event.register("farm", function() return
	{
		Event.EVENT_APP_START,
		"EOF"
	}
	end
)
