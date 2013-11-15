local os = os
local print = print

local time_ = 0
local time_table_ = {}

function kode.bm_start(name)
	if name then
		time_table_[name] = os.time()
	else
		time_ = os.time()
	end
end

function kode.bm_end(name)
	local diff_
	if name then
		if time_table_[name] then
			diff_ = os.time() - time_table_[name]
		end
		time_table_[name] = os.time()
	else
		name = "global"
		diff_ = os.time() - time_
		time_ = os.time()
	end
	print("benchmark[%s]: %s(ms)", name, diff_)

	return diff_
end

--[==[
Usage:
	-- ### sample 1:
	benchmark.bm_start()
	...
	benchmark.bm_end()

	output:
	benchmark: 6(ms)

	--- ### sample 2:
	benchmark.bm_start("aaa")
	...
	benchmark.bm_end("aaa")

	output:
	benchmark[aaa]: 5(ms)

	...
	benchmark.bm_end("aaa")

	output:
	benchmark[aaa]: 4(ms)

--]==]