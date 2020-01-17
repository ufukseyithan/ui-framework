ui = {}

ui.version = "2.4"

ui.path = "sys/lua/ui-framework/"


ui.luaFiles = {
    "config",
    "functions",
    "user",
    "style",
    "objects",
    "hooks"
}

for k, v in pairs(ui.luaFiles) do
    dofile(ui.path..v..".lua")
end

if ui.config.textwidthLibrary then  
    dofile(ui.path.."/textwidth/imageFont.lua")

    imageFont.Load(ui.path.."/textwidth/font.dat")
end

print("\169000255000UI Framework "..ui.version.." is ready to use!")
