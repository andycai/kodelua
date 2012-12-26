local Object = require "kodelua.object"
local facade = require "kodelua.mvc.facade"

local Notifier = Object:Extend()

function Notifier:SendNotification(name, body, kind)
	facade:SendNotification(name, body, kind)
end

function Notifier:Notify(name, body, kind)
	self:SendNotification(name, body, kind)
end

return Notifier