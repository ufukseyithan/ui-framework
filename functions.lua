ui.funcs = {}

function ui.funcs.deepcopy(object)
	local lookup_table = {}
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end
		local new_table = {}
		lookup_table[object] = new_table
		for index, value in pairs(object) do
			new_table[_copy(index)] = _copy(value)
		end
		return setmetatable(new_table, getmetatable(object))
	end
	return _copy(object)
end

function ui.funcs.info(text)
    if not ui.config.consoleOutputs then return end

    print("\169128255255[INFO]: "..text)
end

function ui.funcs.error(text)
    if not ui.config.consoleOutputs then return end

    print("\169255000128[ERROR]: "..text)
end

function ui.funcs.convertX(id, x)
    return (x / 850) * player(id, "screenw")
end

function ui.funcs.convertY(id, y)
    return (y / 480) * player(id, "screenh")
end

function ui.funcs.getMouseX(id)
    local x
    
    if player(id, "health") <= 0 then
        reqcld(id, 0)

        x = ui.user.list[id].mouseX
    else
        x = player(id, "mousex")
    end

    return ui.funcs.convertX(id, x)
end

function ui.funcs.getMouseY(id)
    local y
    
    if player(id, "health") <= 0 then
        reqcld(id, 0)

        y = ui.user.list[id].mouseY
    else
        y = player(id, "mousey")
    end

    return ui.funcs.convertY(id, y)
end

function ui.funcs.get1x1Image()
    return ui.paths.gfx.."1x1.bmp"
end

function ui.funcs.isInside(x, y, x1, y1, x2, y2)
    return ((x > x1) and (y > y1) and (x < x2) and (y < y2))
end

function ui.funcs.checkHoveredExists(id)
    for k, v in pairs(ui.user.list[id].objects["buttons"]) do
        if v.hovered then
            return true
        end
    end

    for k, v in pairs(ui.user.list[id].objects["imageButtons"]) do
        if v.hovered then
            return true
        end
    end
end

function ui.funcs.click(id)
    local x, y = ui.funcs.getMouseX(id), ui.funcs.getMouseY(id)

    for k, v in pairs(ui.user.list[id].objects["buttons"]) do
        if ui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
            if v.onClick then
                v.onClick(id, v)
            end
        end
    end

    for k, v in pairs(ui.user.list[id].objects["imageButtons"]) do
        if ui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
            if v.onClick then
                v.onClick(id, v)
            end
        end
    end
end

function ui.funcs.rightClick(id)
    local x, y = ui.funcs.getMouseX(id), ui.funcs.getMouseY(id)

    for k, v in pairs(ui.user.list[id].objects["buttons"]) do
        if ui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
            if v.onRightClick then
                v.onRightClick(id, v)
            end
        end
    end

    for k, v in pairs(ui.user.list[id].objects["imageButtons"]) do
        if ui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
            if v.onRightClick then
                v.onRightClick(id, v)
            end
        end
    end
end

function ui.funcs.hover()
    for _, i in pairs(player(0, "table")) do
        local x, y = ui.funcs.getMouseX(i), ui.funcs.getMouseY(i)

        if #ui.user.list[i].objects["buttons"] > 0 then
            for k, v in pairs(ui.user.list[i].objects["buttons"]) do
                if not ui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
                    if v.onUnhover then
                        if ui.config.limitedHovering then
                            if v.hovered then
                                v.onUnhover(i, v)

                                v.hovered = false
                            end
                        else
                            v.onUnhover(i, v)
                        end
                    end
                end
            end

            for k, v in pairs(ui.user.list[i].objects["buttons"]) do
                if ui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
                    if v.onHover and not v.hovered then
                        v.onHover(i, v)

                        if ui.config.limitedHovering then
                            v.hovered = true
                        end
                    end
                end
            end
        end

        if #ui.user.list[i].objects["imageButtons"] > 0 then
            for k, v in pairs(ui.user.list[i].objects["imageButtons"]) do
                if not ui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
                    if v.onUnhover then
                        if ui.config.limitedHovering then
                            if v.hovered then
                                v.onUnhover(i, v)

                                v.hovered = false
                            end
                        else
                            v.onUnhover(i, v)
                        end
                    end
                end
            end

            for k, v in pairs(ui.user.list[i].objects["imageButtons"]) do
                if ui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
                    if v.onHover and not v.hovered then
                        v.onHover(i, v)

                        if ui.config.limitedHovering then
                            v.hovered = true
                        end
                    end
                end
            end
        end
    end
end
timer(ui.config.mouseRefreshRate, "ui.funcs.hover", "", 0)
