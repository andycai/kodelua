bit = {}

function bit.b(p)
	return 2 ^ (p - 1)  -- 1-based indexing
end

-- Typical call:  if bit.and(x, bit.b(3)) then ...
function bit.band(x, p)
	return x % (p + p) >= p       
end

function bit.setbit(x, p)
	return bit.band(x, p) and x or x + p
end

--[==[
BIT_FRAME_TITLE = 1
BIT_FRAME_CLOSE = 2
print(bit.setbit(BIT_FRAME_TITLE, BIT_FRAME_CLOSE))
print(bit.band(3, BIT_FRAME_TITLE))
print(bit.band(7, 1))
print(bit.band(7, 2))
print(bit.band(7, 3))
print(bit.band(8, 4))
--]==]