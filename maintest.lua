(function(...)
	args = {...}
	for i=1, #args do
		local pkgPath = package.path  
		package.path = string.format("%s;%s?.lua;%s?/init.lua",  
			pkgPath, args[i], args[i]) 
	end
end)("./3rdparty/")

-- test stringutil
local stringutil = require "kodelua.strings"

tmp = stringutil.Split("go,c,c++, lua", ",")
for k, v in ipairs(tmp) do
	print(v)
end

local strT = {}
stringutil.PushBuffer(strT, "hello, ")
stringutil.PushBuffer(strT, "world!")

print(stringutil.PullBuffer(strT))

-- test mvcs
local Context = require "kodelua.mvcs.context"
local context = Context:New()
print(context.controllers)

-- oop
local Object = require "kodelua.object"
local Person = Object:Extend{
	name = "Andy";
	go = function() print(self.name .. "__gpgpgp") end
}

function Person:Print()
	print(self.name)
end

local jack = Person:Extend{
	name = "jack";
	go = function(self)
		print(self.name)
	end;
}

jack:Print()
jack:go()

-- Person:go()

Person:Print()

-- ref
ref1 = {name="ref1"}
ref2 = ref1
print(ref1.name)
print(ref2.name)
ref2 = {name="ref2"}
print(ref1.name)
print(ref2.name)

print(package.path)
print(package.cpath)

-- init.lua
-- require "kodelua"

-- fmt package
local fmt = require "kodelua.fmt"
fmt.Print("hello, fmt.Print\n")
fmt.Println("hello, fmt.Println")
fmt.Printf("hello, %s", "fmt.Printf")
fmt.Println(fmt.Sprintf("hello, %s", "fmt.Sprintf"))


-- json test
libJson = require "kodelua.encoding.json"
utils = require "kodelua.util"
 local t = {
    ["name1"] = "value1",
    ["name2"] = {1, false, true, 23.54, "a \021 string"},
    -- name3 = libJson.null()
 }

local json = libJson.Encode (t)
print (json)
--> {"name1":"value1","name3":null,"name2":[1,false,true,23.54,"a \u0015 string"]}

function f(...)
	a = "a" + 1
end

function handleErr( ... )
	print(debug.traceback())
end

local ok, msg = xpcall(f, handleErr)

-- assert(false, 'aa')
local ok, msg = pcall(f, "bbb", "dddddd")

print(msg)

local t = libJson.Decode(json)
print(t.name2[4])
-- utils.Dump(t)
--> 23.54


--- i18n 
s = require "kodelua.i18n"

s:SetNamespace("en")

s:Set('money', 'I have %s dollars')
s:Set('wow', 'So much money!')

print(s('money', 1000)) -- I have 1000 dollars

s:SetNamespace("fr") -- switch to french!
s:Set('wow', "Tant d'argent!")

print(s('wow')) -- Tant d'argent!
s:SetNamespace("en")  -- switch back to english!
print(s('wow')) -- So much money!