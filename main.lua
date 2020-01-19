ui = {}

ui.version = "2.4.1"

ui.paths = {
    gfx = "gfx/ui-framework/",
    sys = "sys/lua/ui-framework/"
}

ui.luaFiles = {
    "config",
    "functions",
    "user",
    "style",
    "objects",
    "hooks"
}

for k, v in pairs(ui.luaFiles) do
    dofile(ui.paths.sys..v..".lua")
end

ui.paths.lib = ui.paths.sys.."lib/"

if ui.config.textwidthLibrary then  
    dofile(ui.paths.lib.."/textwidth/imageFont.lua")

    imageFont.Load(ui.paths.lib.."/textwidth/font.dat")
end

print("\169000255000UI Framework "..ui.version.." is ready to use!")
