if kode == nil then return end

Event.EVENT_MODULE_GET_SOMETHING = "module_get_something"

Event.register("{{name}}", 
	{
		Event.EVENT_MODULE_GET_SOMETHING
	}
)