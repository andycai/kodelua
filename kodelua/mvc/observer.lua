local Object = require "kodelua.object"

local Observer = Object:Extend{
	notify = "";
	context = {}
}

function Observer:NotifyObserver(notification)
	self.context[self.notify](self.context, notification)
end

function Observer:CompareNotifyContext(object)
	return object == self.context
end

return Observer