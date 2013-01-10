local baseService = KNotifier:Extend{
	Name = "BaseService";
	action = "";
	param = {}
}

function baseService:Request()
	-- request to network with c++ interface "RequestServer"
	local requestString = json.Encode({act=self.action; param=self.param})
	-- print(requestString)
	-- RequestServer(requestString)
	RequestServer("{\"act\":\"role.online\",\"param\":{\"token\":\"0ee4E+IXfvKm5mG+/GFGrOp2bOcbo/jM75XFD5KrVCIKGhTR8EkcXgr32UgY2uxXZdKMYRQPBWhmqwjPvuZJ10O+suflEaO72lrsIa4ci7KjNFpHHXc4qSCFe8Sj8a8QlURgFPLnuK98IL+s+zw6NZb284EW51RRSWP4bJFSD0f4r44QqieA3LzdHT2/bM0xJBx3Eq/azUxJM7Sl4ajO1fp7Zzd80x0EzknHXM0XjdnH4yA\"}}")
	-- RequestServer("{\"act\":\"role.online\",\"param\":{\"token\":\"c6f6tl4SmHObmqMlr8fy1qIze4YPW+ldNz320qfNbUpb/NmQePbWZJRA/boMG+fg0Ti/sxkOtBo2o1w9n0d+oJ4r8+T8mzPl/xYLfwtVqATHpPyK4oVEGj+2HjIeOSr8SRRW0zG0glNbVDZEQHiQQGopA58SNONqEHJQ5QfPeVqocteNnBzWpIReKALWbPEsWOlqdhKHQgaY/sGshI9JGcVMIGXlRI8KG6kUJgqyj+IsUQSReVtlrRQ3LEKfTbGt8snPGfuRSn9lBxxRbA+4X0hrLPUDaLONMaSZ+xHylaR0RwtkTeaS80Oi9qnZUw\"}}")
end

return baseService