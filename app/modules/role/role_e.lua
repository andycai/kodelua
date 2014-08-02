if kode == nil then return end

Event.EVENT_BAG_GET_SIZE = "bag_get_size"

Event.register("role", 
	{
		Event.EVENT_APP_START,
		Event.EVENT_BAG_GET_SIZE
	}
)