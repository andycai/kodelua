local Notification = Object:Extend{
	name = "";
	body = {};
	kind = "";
}

function Notification:Tostring()
	local msg = ""
	msg = msg .. "Notification Name: " .. self.name
	msg = msg .. ", Notification Body: " .. self.body
	msg = msg .. ", Notification Type: " .. self.kind
	return msg
end

return Notification