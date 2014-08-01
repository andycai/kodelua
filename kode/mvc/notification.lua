kode = kode or {}

kode.notification = kode.object:extend{
	name = "";
	body = {};
	type = "";
}

function kode.notification:tostring()
	local msg = ""
	msg = msg .. "Notification Name: " .. self.name
	msg = msg .. ", Notification Body: " .. self.body
	msg = msg .. ", Notification Type: " .. self.type
	return msg
end