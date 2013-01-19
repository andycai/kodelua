kode.notification = kode.object:extend{
	name = "";
	body = {};
	kind = "";
}

function kode.notification:tostring()
	local msg = ""
	msg = msg .. "Notification Name: " .. self.name
	msg = msg .. ", Notification Body: " .. self.body
	msg = msg .. ", Notification Type: " .. self.kind
	return msg
end