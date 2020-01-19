ui = {}

ui.version = "2.4.1"

ui.paths = {
    gfx = "gfx/ui-framework/"
}

ui.sourceScripts = {
    "config",
    "functions",
    "user",
    "style",
    "objects",
    "hooks"
}

local function getLocalDir()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end

ui.paths.lua = getLocalDir()

for k, v in pairs(ui.sourceScripts) do
    dofile(ui.paths.lua..v..".lua")
end

ui.paths.lib = ui.paths.lua.."lib/"

if ui.config.textwidthLibrary then  
    dofile(ui.paths.lib.."/textwidth/imageFont.lua")

    imageFont.Load(ui.paths.lib.."/textwidth/font.dat")
end

print("\169000255000UI Framework "..ui.version.." is ready to use!")
