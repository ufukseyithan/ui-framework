ui.objects = {}

function ui.objects.createImage(id, path, x, y, style)
    local self = {}

    self.x = x
    self.y = y
    self.path = path
    self.image = image(path, x, y, 2, id)
    self.playerId = id
    self.id = ui.user.getObjectId(id, "images")

    self.style = style or {}

    function self.setPath(path)
        if not path then return end

        freeimage(self.image)
        self.image = image(path, self.x, self.y, 2, id)
        self.path = path

        self.update()
    end
    function self.setPos(x, y)
        if not x or not y then return end

        imagepos(self.image, x, y, imageparam(self.image, "rot"))

        self.x = x
        self.y = y
    end
    function self.setStyle(style)
        if not style then return end

        self.style = style

        self.update()
    end

    function self.update()
        self.width = imageparam(self.image, "width")
        self.height = imageparam(self.image, "height")

        local styleProperties = ui.style.getProperties(self.style)

        imagescale(self.image, styleProperties.xScale or 1, styleProperties.yScale or 1)
        imagealpha(self.image, styleProperties.alpha or 1)

        if styleProperties.color then
            imagecolor(self.image, styleProperties.color[1] or 255, styleProperties.color[2] or 255, styleProperties.color[3] or 255)
        end
    end
    function self.remove()
        freeimage(self.image)

        ui.user.list[id].objects["images"][self.id] = nil
    end

    self.update()

    ui.user.list[id].objects["images"][self.id] = self
    return self
end

function ui.objects.createText(id, text, x, y, align, vAlign, style)
    local self = {}

    self.x = x
    self.y = y
    self.text = text
    self.playerId = id
    self.id = ui.user.getObjectId(id, "texts")

    if self.id > 200 then
        ui.funcs.error("Text couldn't be created, it reached to the limit (> 200).")
        return
    end

    self.style = style or {}
    self.align = align or 0
    self.vAlign = vAlign or 0

    function self.setText(text)
        if not text then return end

        self.text = text

        self.update()
    end
    function self.setPos(x, y)
        if not x or not y then return end

        self.x = x
        self.y = y

        self.update()
    end
    function self.setAlign(align)
        if not align then return end

        self.align = align

        self.update()
    end
    function self.setVAlign(vAlign)
        if not vAlign then return end

        self.vAlign = vAlign

        self.update()
    end
    function self.setStyle(style)
        if not style then return end

        self.style = style

        self.update()
    end

    function self.removeBackground()
        if self.background then
            self.background.remove()
        end
    end
    function self.update()
        self.width, self.height = textwidth(self.text, textSize), textSize 

        local styleProperties = ui.style.getProperties(self.style)

        local textSize = styleProperties.textSize or 13

        if ui.config.textwidthLibrary then
            if styleProperties.background and not styleProperties.background.avoidDuplicate then
                local padding = (styleProperties.background.padding or 0) * 2
                
                local x, y = self.x, self.y
                if self.align == 0 then
                    x = x + width / 2
                elseif self.align == 2 then
                    x = x - width / 2
                end

                if self.vAlign == 0 then
                    y = y + height / 2
                elseif self.vAlign == 2 then
                    y = y - height / 2
                end

                self.width, self.height = width + padding, height + padding

                if self.background then
                    self.background.setStyle({
                        xScale = width,
                        yScale = height,
                        color = styleProperties.background.color,
                        alpha = styleProperties.background.alpha
                    })
                else
                    self.background = ui.objects.createImage(id, ui.funcs.get1x1Image(), x, y, {
                        xScale = width,
                        yScale = height,
                        color = styleProperties.background.color,
                        alpha = styleProperties.background.alpha
                    })
                end

                if self.background then
                    self.background.setPos(x, y)
                end 
            else
                self.removeBackground()
            end
        end

        parse('hudtxt2 '..id..' '..(self.id - 1)..' "\169'..(styleProperties.textColor or "255255255")..self.text..'" '..self.x..' '..self.y..' '..self.align..' '..self.vAlign..' '..textSize)
    end
    function self.remove()
        parse('hudtxt2 '..id..' '..self.id - 1)

        ui.user.list[id].objects["texts"][self.id] = nil
    end

    self.update()

    ui.user.list[id].objects["texts"][self.id] = self
    return self
end

function ui.objects.createButton(id, text, x, y, width, height, style)
    local self = {}

    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.text = text
    self.textObject = ui.objects.createText(id, text, x, y, 1, 1, style)
    self.playerId = id
    self.id = ui.user.getObjectId(id, "buttons")

    self.style = style or {}

    function self.setPos(x, y)
        if not x or not y then return end

        self.x = x
        self.y = y

        self.update()
    end
    function self.setText(text)
        if not text then return end

        self.text = text

        self.update()
    end
    function self.setSize(width, height)
        self.width = width or self.width
        self.height = height or self.height

        self.update()
    end
    function self.setStyle(style)
        if not style then return end

        self.style = style

        self.update()
    end

    function self.removeBackground()
        if self.background then
            self.background.remove()
        end
    end
    function self.update()
        if self.width == true then
            self.autosize = true
            self.padding = self.height
        end

        local styleProperties = ui.style.getProperties(self.style)

        if self.autosize and ui.config.textwidthLibrary then
            local textSize = styleProperties.textSize or 13

            local padding = (self.padding or 0) * 2

            self.width, self.height = textwidth(self.text, textSize) + padding, textSize + padding
        end

        if styleProperties.background then
            if self.background then
                self.background.setStyle({
                    xScale = self.width,
                    yScale = self.height,
                    color = styleProperties.background.color,
                    alpha = styleProperties.background.alpha
                })
            else
                self.background = ui.objects.createImage(id, ui.funcs.get1x1Image(), self.x, self.y, {
                    xScale = self.width,
                    yScale = self.height,
                    color = styleProperties.background.color,
                    alpha = styleProperties.background.alpha
                })
            end

            if self.background then
                self.background.setPos(x, y)
            end 

            -- Avoiding two different backgrounds from each object
            styleProperties.background.avoidDuplicate = true
        else
            self.removeBackground()
        end

        self.textObject.setText(self.text)
        self.textObject.setPos(self.x, self.y)
        self.textObject.setStyle(self.style)
    end 
    function self.remove()   
        self.removeBackground()
        self.textObject.remove()

        ui.user.list[id].objects["buttons"][self.id] = nil
    end

    self.update()

    ui.user.list[id].objects["buttons"][self.id] = self
    return self
end

function ui.objects.createImageButton(id, path, x, y, width, height, style)
    local self = {}

    self.x = x
    self.y = y
    self.path = path
    self.width = width
    self.height = height
    self.imageObject = ui.objects.createImage(id, path, x, y, style)
    self.playerId = id
    self.id = ui.user.getObjectId(id, "imageButtons")

    self.style = style or {}

    function self.setPos(x, y)
        if not x or not y then return end

        self.imageObject.setPos(x, y)
        if self.background then
            self.background.setPos(x, y)
        end 

        self.x = x
        self.y = y
    end
    function self.setPath(path)
        if not path then return end

        self.path = path

        self.update(true)
    end
    function self.setSize(width, height)
        self.width = width or self.width
        self.height = height or self.height

        self.update()
    end
    function self.setStyle(style)
        if not style then return end

        self.style = style

        self.update()
    end
    
    function self.removeBackground()
        if self.background then
            self.background.remove()
        end
    end
    function self.update(updatePath)
        local styleProperties = ui.style.getProperties(self.style)
        
        if styleProperties.background then
            if self.background then
                self.background.setStyle({
                    xScale = self.width,
                    yScale = self.height,
                    color = styleProperties.background.color,
                    alpha = styleProperties.background.alpha
                })
            else
                self.background = ui.objects.createImage(id, ui.funcs.get1x1Image(), self.x, self.y, {
                    xScale = self.width,
                    yScale = self.height,
                    color = styleProperties.background.color,
                    alpha = styleProperties.background.alpha
                })
            end

            self.background.setPos(self.x, self.y)
        else
            self.removeBackground()
        end

        if updatePath then
            self.imageObject.setPath(self.path)
        end

        self.imageObject.setStyle(self.style)
    end
    function self.remove()
        self.removeBackground()
        self.imageObject.remove()

        ui.user.list[id].objects["imageButtons"][self.id] = nil
    end

    self.update()

    ui.user.list[id].objects["imageButtons"][self.id] = self
    return self
end

function ui.objects.createWindow(id, path, x, y, style, interact, width, height)
    local self = {}

    self.x = x
    self.y = y
    self.path = path
    self.playerId = id
    self.id = ui.user.getObjectId(id, "windows")
    self.objects = {}

    self.style = style or {}
    self.interact = interact or false
    self.width = width or false
    self.height = height or false

    if path == "invisible" then
        self.imageObject = false
    elseif type(path) == "table" then
        self.imageObject = ui.objects.createImage(id, ui.funcs.get1x1Image(), x, y, {
            color = {unpack(path[1])}, 
            alpha = path[2],
            xScale = width,
            yScale = height
        })
    else
        self.imageObject = ui.objects.createImage(id, path, x, y)
    end

    function self.addObject(...)
        for i = 1, #arg do
            table.insert(self.objects, arg[i])
        end

        self.update()
    end
    function self.removeObject(remove, ...)
        for k, v in pairs(self.objects) do
            for i = 1, #arg do
                if v == arg[i] then
                    if remove then v.remove() end
                    self.objects[k] = nil
                end
            end
        end
    end
    function self.setPos(x, y)
        if not x or not y then return end

        self.x = x
        self.y = y

        self.update()
    end
    function self.setStyle(style)
        if not style then return end

        self.style = style

        self.update()
    end

    function self.update()
        if self.imageObject then
            self.imageObject.setPos(self.x, self.y)
        end 

        if self.interact then
            for k, v in pairs(self.objects) do
                v.setStyle(self.style)
            
                local newX = (v.x / player(id, "screenw")) * self.width
                local newY = (v.y / player(id, "screenh")) * self.height

                v.setPos(self.x - (self.width / 2) + newX, self.y - (self.height / 2) + newY)
            end
        end
    end
    function self.remove()
        if self.imageObject then
            self.imageObject.remove()
        end
        
        for k, v in pairs(self.objects) do
            v.remove()
        end

        ui.user.list[id].objects["windows"][self.id] = nil
    end

    ui.user.list[id].objects["windows"][self.id] = self
    return self
end 