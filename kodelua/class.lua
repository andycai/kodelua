local class = {}

local function addsupers(target, supers)
	for i=1,#supers do -- faster than ipairs
		local super = supers[i]
		for k,v in pairs(super) do
			if not target[k] then
				target[k] = v
			end
		end
		addsupers(target, super.__supers or {})
	end
end

local function instantiate(tk, ...)
	local instance={}
	setmetatable(instance,tk.__classmeta)
	return (instance.new and instance:new(...)) or instance
end

local function fix_supers(tk, ...)
	tk.__call = instantiate
	addsupers(tk,tk.__supers)
	return instantiate(tk,...)
end

local function newclass(klstab, kls)
	if rawget(getfenv(), kls) then
		error("The class `"..kls.."` is already defined in this namespace!", 2)
	end
	return function(...)
		local meta = {}
		local supers = {...}
		meta.__classmeta = {
			__index=meta, -- this is the actual metatable for instances
			__tostring = function(self)
				return kls and ("instance of `"..kls.."`") or "instance of anonymous class"
			end
		}
		meta.__class = kls -- class name, just for reference
		meta.__supers = supers -- list of superclasses

		-- primitive meta(__) function
		meta.__index = supers[1]
		meta.__tostring = function(self)
			return kls and ("class `"..kls.."`") or "anonymous class"
		end
		meta.__call = fix_supers
		meta.instanceof = function(self, ...)
			assert(getmetatable(self)==meta.__classmeta)
			local totest = {...}
			for i=1,#totest do
				for j=1,#supers do
					if meta.__supers[j] == totest[i] then
						return true
					end
				end
			end
			return false
		end
		setmetatable(meta, meta)
		if kls then rawset(getfenv and getfenv() or _ENV, kls, meta) end
		return meta
	end
end

return setmetatable(class, {
	__index = newclass,
	__call = function(t,...)
		return newclass(nil,nil)(...)
	end
})

--[==[
-- simple class creation
A = Class()
assert(tostring(A) == "anonymous class")

-- static attribute behavior
A = Class {
	static1 = 1,
	static2 = 2
}
i1 = A()
i2 = A()
i1.static1 = 10
assert(i2.static1 == 1)
A.static1 = 20
assert(i1.static1 == 10)
assert(i2.static1 == 20)

-- inheritance
A = Class {
	attr = 1
}

B = Class(A, {
	attr = 2
})

C = Class({ attr = 3 })
a,b,c = A(),B(),C()
assert(a.attr==1)
assert(b.attr==1)
assert(c.attr==3)

-- inheritance
A = Class()
function A:new(val)
	self.val = val
	self.attr = 1
end

B = Class(A)
function B:new(val)
	A.new(self, val)
	assert(self.attr == 1)
	self.attr = 2
end
assert(B().attr == 2)

-- multiple inheritance
A.a = 1
B.b = 2
C = Class(A,B)
c=C(4)
assert(c.val==4 and c.a == 1 and c.b == 2)

-- global class uniqueness
Class.Test()
assert(not pcall(function() Class.Test() end))

-- instanceof
-- Class.Test2(Test)
-- t=Test2()
-- assert(t:instanceof(Test))

print("All tests passed")
--]==]