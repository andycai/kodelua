kode = kode or {}

kode.notifier = kode.object:extend()

function kode.notifier:sendNotification(name, body, type_)
	kode.facade:sendNotification(name, body, type_)
end

function kode.notifier:send(name, body, type_)
	self:sendNotification(name, body, type_)
end

function kode.notifier:notify(name, body, type_)
	self:sendNotification(name, body, type_)
end