function kode.scandir(directory)
    local i, t, popen = 0, {}, io.popen
    -- for filename in popen('ls -a "'..directory..'"'):lines() do
    for filename in popen('dir "'..directory..'" /b /ad'):lines() do
        i = i + 1
        t[i] = filename
    end
    return t
end

function kode.fread(path)
	local file = io.open(path, "r")
	if file then
		local content = file:read("*a")
		io.close(file)
		return content
	end
	return nil
end

function kode.fwirte(path, content)
	local file = io.open(path, "w+")
	if file then
		if file:write(content) == nil then return false end
		io.close(file)
		return true
	else
		return false
	end
end

function kode.fexists(path)
	local file = io.open(path, "r")
	if file then
		io.close(file)
		return true
	end
	return false
end

function kode.filesize(path)
	local size = false
	local file = io.open(path, "r")
	if file then
		local current = file:seek()
		size = file:seek("end")
		file:seek("set", current)
		io.close(file)
	end
	return size
end

-- returns information [dirname, filename, basename, extname] about a file path
function kode.pathinfo(path)
	local pos = string.len(path)
	local extpos = pos + 1
	while pos > 0 do
		local b = string.byte(path, pos)
		if b == 46 then -- 46 = char "."
			extpos = pos
		elseif b == 47 then -- 47 = char "/"
			break
		end
		pos = pos - 1
	end

	local dirname = string.sub(path, 1, pos)
	local filename = string.sub(path, pos + 1)
	extpos = extpos - pos
	local basename = string.sub(filename, 1, extpos - 1)
	local extname = string.sub(filename, extpos)
	return {
		dirname = dirname,
		filename = filename,
		basename = basename,
		extname = extname
	}
end

-- Helper function that loads a file into ram.
function kode.loadfile(fromDir, name)
	local intmp = assert(io.open(from_dir .. name, 'r'))
	local content = intmp.read("*a")
	intmp:close()

	return content
end

-- Loads a source file, but converts it with line numbering only
-- showing from first line to last line
function kode.loadlines(source, first, last)
	local f = io.open(source)
	local lines = {}
	local i = 0

	for line in f:lines() do
		i = i + 1

		if i >= first and i <= last then
			lines[#lines + 1] = ("%0.4d: %s"):format(i, line)
		end
	end

	return table.concat(lines, '\n')
end