local Notifier = Object:Extend()

function Notifier:SendNotification(name, body, kind)
	KFacade:SendNotification(name, body, kind)
end

function Notifier:Notify(name, body, kind)
	self:SendNotification(name, body, kind)
end

return Notifier