ui.user = {}

ui.user.list = {}

for i = 1, 32 do
    ui.user.list[i] = ui.funcs.deepcopy(ui.config.userPrototype)
end

function ui.user.getObjects(id)
    local tbl = {}

    if id then
        if ui.user.list[id] then
            table.insert(tbl, ui.user.list[id].objects)
        end
    else
        for i = 1, 32 do
            table.insert(tbl, ui.user.list[i].objects)
        end
    end

    return tbl
end

function ui.user.remove(id)
    for k, v in pairs(ui.user.getObjects(id)) do
        for a, b in pairs(v) do
            for c, d in pairs(b) do
                d.remove()
            end
        end
    end

    ui.user.list[id] = ui.funcs.deepcopy(ui.config.userPrototype)
end

function ui.user.getObjectId(id, object)
    return #ui.user.list[id].objects[object] + 1
end
