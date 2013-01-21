number = {}

-- local numberToMonth = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }
local numberToMonth = { "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月" }
function number.toMonth(n)
	n = tonumber(n)
	return numberToMonth[n]
end

function number.tocurrency(n)
	return "$" .. number.commaSeperate(n)
end

function number.commaSeperate(n)
	local formatted = tostring(n)
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if k ==0 then break end
	end

	return formatted
end