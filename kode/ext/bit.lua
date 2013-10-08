bit = {}

function bit.b(p)
	return 2 ^ (p - 1)  -- 1-based indexing
end

-- Typical call:  if bit.and(x, bit.b(3)) then ...
function bit.band(x, p)
	return x % (p + p) >= p       
end

--[==[
print(bit.band(7, 1))
print(bit.band(7, 2))
print(bit.band(7, 3))
print(bit.band(8, 4))
--]==]