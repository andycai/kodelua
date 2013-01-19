kode.notifier = kode.object:extend()

function kode.notifier:sendNotification(name, body, kind)
	kode.facade:sendNotification(name, body, kind)
end

function kode.notifier:notify(name, body, kind)
	self:sendNotification(name, body, kind)
end