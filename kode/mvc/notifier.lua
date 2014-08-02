kode = kode or {}

kode.notifier = kode.object:extend()

function kode.notifier:send(name, body, type_)
	kode.facade:send(name, body, type_)
end

function kode.notifier:sendNotification(name, body, type_)
	print("sendNotification() was deprecated please use send() instead")
	self:send(name, body, type_)
end

function kode.notifier:notify(name, body, type_)
	print("notify() was deprecated please use send() instead")
	self:send(name, body, type_)
end