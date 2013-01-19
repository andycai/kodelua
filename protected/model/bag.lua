local bagmodel = BaseModel:extend{
	EVENT_BAG_GET = "EVENT_BAG_GET";
	EVENT_BAG_TIDY = "EVENT_BAG_TIDY"
}
local meta = basemodel

function meta:getData()
    -- body
end
function meta:setData(param)
    -- body
end

return meta