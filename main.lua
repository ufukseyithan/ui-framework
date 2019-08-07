ui = {}

ui.path = "sys/lua/ui-framework/"

ui.version = "2.3"

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

print("\169000255000UI Framework "..ui.version.." is ready to use!")
