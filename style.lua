ui.style = {}

ui.style.list = {}

function ui.style.check(name)
    return ui.style.list[name]
end

function ui.style.new(name, properties)
    if not ui.style.check(name) then
        ui.style.list[name] = properties

        ui.funcs.info("\""..name.."\" style is created.")
    else
        ui.funcs.error(name.." style exists already. Do not create the same style more than once!")
    end
end

function ui.style.remove(name)
    if not ui.style.check(name) then
        ui.funcs.error("Style couldn't be found.")
    else
        ui.stlye.list[name] = nil
        ui.funcs.info("\""..name.."\" style is removed.")
    end
end

function ui.style.getProperties(name)
    if type(name) == "table" then 
        return name 
    end

    if ui.style.check(name) then
        return ui.style.check(name)
    else
        ui.funcs.error("Style \""..tostring(name).."\" couldn't be found.")
        return {}
    end
end

function ui.style.setProperty(name, property, val)
    if ui.style.check(name) then
        ui.style.list[name][property] = val

        for k, v in pairs(ui.user.getObjects()) do
            for a, b in pairs(v) do
                for c, d in pairs(b) do
                    if d.style and d.style == name then
                        d.update()
                    end
                end
            end
        end
    else 
        ui.funcs.error("Style \""..tostring(name).."\" couldn't be found.")
    end
end