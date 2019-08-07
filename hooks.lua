parse("debuglua 0")

ui.hooks = {}

addhook("clientdata", "ui.hooks.clientdata")
function ui.hooks.clientdata(id, mode, data1, data2)
    if mode == 0 then
        ui.user.list[id].mouseX = data1
        ui.user.list[id].mouseY = data2
    end
end

addhook("leave", "ui.hooks.leave")
function ui.hooks.leave(id)
    ui.user.remove(id)
end

addbind(ui.config.pressKey)
addbind(ui.config.pressRightKey)

addhook("key", "ui.hooks.key")
function ui.hooks.key(id, key, state)
    if key == ui.config.pressKey then
        if state == 1 then
            ui.funcs.click(id)
        end
    elseif key == ui.config.pressRightKey then
        if state == 1 then
            ui.funcs.rightClick(id)
        end
    end
end

parse("debuglua 1")