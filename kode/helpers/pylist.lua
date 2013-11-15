-- Emulation of Python lists
-- Nick Trout
-- See http://www.python.org/doc/current/tut/tut.html, section 5.1
-- Note:The comments before some of the functions are from the Python docs
-- and contain Python code.
-- Written for Lua version 4.0
-- Redone for Lua 5.1, Steve Donovan.

--[[==
lst = List:new()  -- create an empty List
lst2 = List:new{1,2,"blah",lst}  -- create a list with some items in
lst3 = List {10,20,30}  -- List acts like a 'constructor'
-- Our new methods
lst:append("hello")
lst:extend{"world", 35, 77, "?"}
lst:insert(3,"how?")
lst:remove(35)
q = lst:pop()
print( lst:index("world") )
print( lst:count("?") )
lst:sort()
lst:reverse()
print( lst[-2] )
a = lst:slice(3)
b = lst:slice(-4,-2)
lst:clear()
lst:range(77)

-- We can mix them with Lua's library calls
table.insert(lst,"boo")
print(#lst)
==]]

local tinsert = table.insert
local tremove = table.remove
local tsort = table.sort
local write = io.write

-- metatable for our list objects
List = {}
List.__index = List
-- we give the metatable its own metatable so that we can call it like a function!
_ListMT = {}
setmetatable(List,_ListMT)
function _ListMT.__call(tbl,arg)
	return List:new(arg)
end

-- Handle the index event
-- note: this is called if something is _not_ present in the table. These are either 
-- negative indices, method names, or bad indices.
function List:__index(i)
	local typ = type(i)
	if typ=="string" then
	local fn = List[i]
	if not fn then error("Bad List function: "..i) end
	return fn
	elseif typ=="number" then
	if i<0 then
		local sz = #self
		if i<-sz then error("List index out of range: "..i) end
		return self[sz+i+1]
	else
		error("Bad list index: "..i)
	end
	end
end

-- The newindex event handles list[i] = val, if i is not present in 
-- the list - used for negative indices!
function List:__newindex(i,val)
	if type(i)=="number" then
	if i<0 then
		local sz = #self
		if i<-sz then error("List index out of range: "..i) end
		self[sz+i+1] = val
	else
		error("Bad list index: "..i)
	end
	end
end

local function simple_table(t)
	return type(t) == 'table' and getmetatable(t) ~= List
end

-- Create a new list. Can optionally pass a list eg. x=List:new{1,2,3}
-- passing another instance of List will cause a _copy_ to be created
-- we pass anything which isn't a simple table to iter() to work out
-- an appropriate iterator
function List:new(t)
	if not t then t={} 
	elseif not simple_table(t) then
	local tbl = t
	t = {}
	for i,v in iter(tbl) do
		tinsert(t,v)
	end
	end
	setmetatable(t,List)
	return t
end

--Add an item to the end of the list; equivalent to a[len(a):] = [x].
function List:append(i)
	tinsert(self,i)
end

-- Extend the list by appending all the items in the given list;
-- equivalent to a[len(a):] = L.
function List:extend(L)
	assert(type(L)=="table","List:extend expecting a table")
	for i,v in ipairs(L) do tinsert(self,v) end
end

-- Insert an item at a given position. The first argument is the index of the
-- element before which to insert, so a.insert(0, x) inserts at the front of
-- the list, and a.insert(len(a), x) is equivalent to a.append(x).
function List:insert(i, x)
	tinsert(self,i,x)
end

-- equivalent of Python's del s[i]
List.delete = tremove

-- Remove the first item from the list whose value is x.
-- It is an error if there is no such item.
function List:remove(x)
	for i=1,#self do
	if self[i]==x then tremove(self,i) return end
	end
	error("List:remove failed, item not found")
end

-- Remove the item at the given position in the list, and return it.
-- If no index is specified, a.pop() returns the last item in the list.
-- The item is also removed from the list.
function List:pop(i)
	if not i then i = #self end
	return tremove(self,i)
end

-- Return the index in the list of the first item whose value is x.
-- It is an error if there is no such item.
function List:index(x)
	for i=1,#self do
	if self[i]==x then return i end
	end
	error("List:index failed, item not found")
end

-- Return the number of times x appears in the list.
function List:count(x)
	local cnt=0
	for i=1,#self do
	if self[i]==x then cnt=cnt+1 end
	end
	return cnt
end

-- Sort the items of the list, in place.
function List:sort()
	tsort(self)
end

-- Reverse the elements of the list, in place.
function List:reverse()
	local t,n={},#self
	for i=1,n do t[i]=self[n-i+1] end -- reverse
	for i=1,n do self[i]=t[i] end -- copy back
end

local function normalize_slice(self,first,last)
	local sz = #self
	if not first then first=1 end
	if first<0 then first=sz+first+1 end
	-- make the range _inclusive_!
	if not last then last=sz end 
	if last < 0 then last=sz+last end
	return first,last
end

-- Emulate the list slice eg. python_list[first:last]
-- If first or last are negative then they are relative to the end of the list
-- eg. slice(-2) gives last 2 entries in a list,
-- eg. slice(-4,-2) gives from -4th to -2nd
function List:slice(first,last)
	first,last = normalize_slice(self,first,last)
	local t=self:new()
	for i=first,last do tinsert(t,self[i]) end
	return t
end

-- empty the list
function List:clear()
	for i=1,#self do tremove(self,i) end
end

-- Emulate Python's range(x) function which gives you a sequence of 0..x-1
-- Include it in List table for tidyness
function List:range(x)
	local t=self
	if type(t) == 'number' then -- we did not get a self argument - it was a number!
	x = t
	t=List:new()    
	end
	for i=0,x-1 do tinsert(t,i) end
	return t
end

-- Python len(list) is the same as #list
function List:len()
	return #self
end

-- Extended operations --

-- equivalent to del s[i1:i2]
function List:chop(i1,i2)
	i1,i2 = normalize_slice(self,i1,i2)
	for i = i1,i2 do
		tremove(self,i1)
	end
end

-- equivalent to s[idx:idx] = seq
function List:splice(idx,seq)
	idx = idx - 1
	for i,v in ipairs(seq) do
		tinsert(self,i+idx,v)
	end
end

-- general slice assignment s[i1:i2] = seq
function List:slice_assign(i1,i2,seq)
	i1,i2 = normalize_slice(self,i1,i2)
	if i2 >= i1 then self:chop(i1,i2) end
	self:splice(i1,seq)
end

-- concatenation operator ..
function List:__concat(L)
	local ls = self:slice(1,-1)  -- making a copy!
	ls:extend(L)
	return ls
end

-- equality operator ==
function List:__eq(L)
--~   print(#self,#L)
	if #self ~= #L then return false end
	for i = 1,#self do
--~     print(self[i],L[i])
	if self[i] ~= L[i] then return false end
	end
	return true
end

-- how our list should be rendered as a string
-- note: really can't handle list items which are not strings or numbers
function List:__tostring()
	return '{'..table.concat(self,',')..'}'
end

-- can use the call notation to extract slices!
function List:__call(first,last)
	return self:slice(first,last)
end

function List:foreach(fun)
	for i,v in ipairs(self) do
	fun(v)
	end
end

-- capturing the Python concept of 'sequence'. 
-- In particular, this makes strings and file objects to be iterable sequences.
function iter(seq)
	if type(seq) == 'string' then
		local idx = 0
		local n = #seq
		local sub = string.sub
		return function ()
			idx = idx + 1
			if idx > n then return nil
			else
				return idx,sub(seq,idx,idx)
			end
		end
	elseif type(seq) == 'table' then
		return ipairs(seq)
	elseif type(seq) == 'function' then
		return seq()
	elseif type(seq) == 'userdata' and io.type(seq) == 'file' then
		local lines = seq:lines()
		local k = 0
		return function ()
			local line = lines()
			if not line then
				return nil 
			else
				k = k + 1
				return k,line
			end
		end			
	end
end

-- test using: lua pylist.lua
--[==[
if arg and arg[0]=="pylist.lua" then
	local pr = function(l)
	for i=1,#l do io.write(l[i],' ') end
	print()
	end
	local lst = List:new()
	lst:append(10)
	lst:extend{20,30,40,50}
	assert (lst == List{10,20,30,40,50})
	lst:insert(3,11)  
	lst:remove(40)
	assert (lst == List{10,20,11,30,50})
	local q=lst:pop()
	assert( lst:index(30)==4 )
	assert( lst:count(10)==1 )
	lst:sort()
	lst:reverse()
	assert (lst == List{30,20,11,10})
	assert (lst[-1] == 10)
	assert (lst[-3] == 20)
	lst = List {10,20,30,40,50}
	assert (lst:slice(2) == List{20,30,40,50})
	assert (lst:slice(-2) == List{40,50})
	assert (lst:slice(nil,3) == List{10,20,30})
	assert (lst:slice(2,4) == List{20,30,40})
	assert (lst:slice(-4,-2) == List{20,30})
	lst = List.range(10)
	seq = List{0,1,2,3,4,5,6,7,8,9}
	assert(lst == seq)
	assert (List('abcd') == List{'a','b','c','d'})
	ls = List{10,20,30,40}
	ls:slice_assign(2,3,{21,31})
	assert (ls == List{10,21,31,40})
end
--]==]