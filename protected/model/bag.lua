local bagmodel = BaseModel:extend{
	EVENT_BAG_GET = "EVENT_BAG_GET";
	EVENT_BAG_TIDY = "EVENT_BAG_TIDY"
}
local meta = basemodel

function meta:getBagData()
    -- body
end
function meta:setBagData(param)
    -- body
end

return meta