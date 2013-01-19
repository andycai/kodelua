kode.observer = kode.object:extend{
	notify = "";
	context = {}
}

function kode.observer:notifyObserver(notification)
	self.context[self.notify](self.context, notification)
end

function kode.observer:compareNotifyContext(object)
	return object == self.context
end