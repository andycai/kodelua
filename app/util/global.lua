ResourcePath = "resource/"

local function getResourcePath(path)
	return ResourcePath .. path .. "/"
end

function GetPngPath(path, name)
	return getResourcePath(path) .. name .. ".png"
end

function GetJpgPath(path, name)
	return getResourcePath(path) .. name .. ".jpg"
end

function GetPlistPath(path, name)
	return getResourcePath(path) .. name .. ".plist"
end

function GetTmxPath(path, name)
	return getResourcePath(path) .. name .. ".tmx"
end

function GetScenePath(name)
	return GetJpgPath("scene", name)
end
function GetSceneTmxPath(name)
	return GetTmxPath("scene", name)
end

function GetHeroPath(name)
	return GetPngPath("hero", "hero"..name)
end
function GetHeroPlistPath(name)
	return GetPlistPath("hero", "hero"..name)
end

function GetNpcPath(name)
	return GetPngPath("npc", "npc"..name)
end
function GetNpcPlistPath(name)
	return GetPlistPath("npc", "npc"..name)
end

function GetWeaponPath(name)
	return GetPngPath("weapon", "weapon"..name)
end
function GetWeaponPlistPath(name)
	return GetPlistPath("weapon", "weapon"..name)
end

function GetMagicPath(name)
	return GetPngPath("magic", "magic"..name)
end
function GetMagicPlistPath(name)
	return GetPlistPath("magic", "magic"..name)
end

function GetMountPath(name)
	return GetPngPath("mount", "mount"..name)
end
function GetMountPlistPath(name)
	return GetPlistPath("mount", "mount"..name)
end

function GetBufferPath(name)
	return GetPngPath("buffer", "buffer"..name)
end
function GetBufferPlistPath(name)
	return GetPlistPath("buffer", "buffer"..name)
end

function GetIconPath(name)
	return GetPngPath("icon", name)
end
function GetIconPlistPath(name)
	return GetPlistPath("icon", name)
end

function GetSharePath(name)
	return GetPngPath("share", name)
end
function GetSharePlistPath(name)
	return GetPlistPath("share", name)
end

function GetUIPath(name)
	return GetPngPath("ui", name)
end
function GetUIPlistPath(name)
	return GetPlistPath("ui", name)
end