gui.funcs = {}

function gui.funcs.deepcopy(object)
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

function gui.funcs.info(text)
    if not gui.config.showConsoleInputs then return end

    print("\169128255255[INFO]: "..text)
end

function gui.funcs.error(text)
    if not gui.config.showConsoleInputs then return end

    print("\169255000128[ERROR]: "..text)
end

function gui.funcs.convertX(id, x)
    return (x / 850) * player(id, "screenw")
end

function gui.funcs.convertY(id, y)
    return (y / 480) * player(id, "screenh")
end

function gui.funcs.getMouseX(id)
    local x
    
    if player(id, "health") <= 0 then
        reqcld(id, 0)

        x = gui.user.list[id].mouseX
    else
        x = player(id, "mousex")
    end

    return gui.funcs.convertX(id, x)
end

function gui.funcs.getMouseY(id)
    local y
    
    if player(id, "health") <= 0 then
        reqcld(id, 0)

        y = gui.user.list[id].mouseY
    else
        y = player(id, "mousey")
    end

    return gui.funcs.convertY(id, y)
end

function gui.funcs.isInside(x, y, x1, y1, x2, y2)
    return ((x > x1) and (y > y1) and (x < x2) and (y < y2))
end

function gui.funcs.checkHoveredExists(id)
    for k, v in pairs(gui.user.list[id].objects["buttons"]) do
        if v.hovered then
            return true
        end
    end

    for k, v in pairs(gui.user.list[id].objects["imageButtons"]) do
        if v.hovered then
            return true
        end
    end
end

function gui.funcs.click(id)
    local x, y = gui.funcs.getMouseX(id), gui.funcs.getMouseY(id)

    for k, v in pairs(gui.user.list[id].objects["buttons"]) do
        if gui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
            if v.onClick then
                v.onClick(id, v)
            end
        end
    end

    for k, v in pairs(gui.user.list[id].objects["imageButtons"]) do
        if gui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
            if v.onClick then
                v.onClick(id, v)
            end
        end
    end
end

function gui.funcs.rightClick(id)
    local x, y = gui.funcs.getMouseX(id), gui.funcs.getMouseY(id)

    for k, v in pairs(gui.user.list[id].objects["buttons"]) do
        if gui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
            if v.onRightClick then
                v.onRightClick(id, v)
            end
        end
    end

    for k, v in pairs(gui.user.list[id].objects["imageButtons"]) do
        if gui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
            if v.onRightClick then
                v.onRightClick(id, v)
            end
        end
    end
end

function gui.funcs.hover()
    for _, i in pairs(player(0, "table")) do
        local x, y = gui.funcs.getMouseX(i), gui.funcs.getMouseY(i)

        if #gui.user.list[i].objects["buttons"] > 0 then
            for k, v in pairs(gui.user.list[i].objects["buttons"]) do
                if not gui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
                    if v.onUnhover then
                        if gui.config.limitedHovering then
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

            for k, v in pairs(gui.user.list[i].objects["buttons"]) do
                if gui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
                    if v.onHover and not v.hovered then
                        v.onHover(i, v)

                        if gui.config.limitedHovering then
                            v.hovered = true
                        end
                    end
                end
            end
        end

        if #gui.user.list[i].objects["imageButtons"] > 0 then
            for k, v in pairs(gui.user.list[i].objects["imageButtons"]) do
                if not gui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
                    if v.onUnhover then
                        if gui.config.limitedHovering then
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

            for k, v in pairs(gui.user.list[i].objects["imageButtons"]) do
                if gui.funcs.isInside(x, y, v.x - v.width / 2, v.y - v.height / 2, v.x + v.width / 2, v.y + v.height / 2) then
                    if v.onHover and not v.hovered then
                        v.onHover(i, v)

                        if gui.config.limitedHovering then
                            v.hovered = true
                        end
                    end
                end
            end
        end
    end
end
timer(gui.config.mouseRefreshRate, "gui.funcs.hover", "", 0)