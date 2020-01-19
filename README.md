# UI Framework
A small framework which helps creating UIs for [CS2D](http://www.cs2d.com/). It is a lot easier to create buttons, texts, images and subsequently interacting with them in matters of styles and events.

## Installation
The installation is quite easy. Create a folder in your `sys/lua` and name it (preferably) "ui-framework" (if you name it differently, you will have to change *paths.sys* in `main.lua` accordingly), and then put all the files into there. Lastly, extract [the required asset .rar file](https://drive.google.com/open?id=1Grh3Zve3MhMk88av-ni58FS5KQqBDeLd) into your CS2D folder.

To get the use of the framework, simply dofile `main.lua` and you are ready to start creating your custom UIs.

## Features

### Objects
You can create objects such as buttons, texts, images and even windows only with a single function. Every function which creates an object, returns object’s data (sort of an ID), meaning you can save their data to variables, and later use them to change their properties or even tie new events to them.
```Lua
local object = ui.objects.createImage(id, path, x, y, style)
```

Create a Button object whose background will be auto-sized by its text width (has padding 10):
```Lua
local button = ui.objects.createButton(id, "Button", x, y, true, 10, {
    background = {
        color = {155, 155, 155},
        alpha = 0.5
    }
})
```
In order this to work, *textwidthLibrary* in `config.lua` should be set to true (default). 

### Styles
Objects may have a style changing their visual look. Defining properties such as color, background, alpha in so-called "patterns" (tables) and then tying them to the objects in certain ways accomplishes it.

Create a style pattern which would make images red when tied:
```Lua
ui.style.new("red", {
    color = {0, 255, 0}
})
```

Create an Image object whose color is red:
```Lua
local object = ui.objects.createImage(id, path, x, y, {
    color = {255, 0, 0}
})
```
Or:
```Lua
local object = ui.objects.createImage(id, path, x, y, "red")
```
Or:
```Lua
object.setStyle("red")
```

Create a Text object that has auto-sized background:
```Lua
local text = ui.objects.createText(id, "Text", x, y, nil, nil, {
    background = {
        color = {155, 155, 155},
        alpha = 0.5,
        padding = 5
    }
})
```
In order this to work, *textwidthLibrary* in `config.lua` should be set to true (default). 

### Events
Objects are not composed of styles, you can likewise specify what to happen when clicking or hovering on them.
```Lua
-- The button becomes red when clicked
local button = ui.objects.createButton(id, "Click", x, y, 32, 32)
button.onClick = function()
    button.setStyle({
        textColor = "255000000"
    })
end
 ```
### Misc
The framework includes several functions that may help you while creating UIs. Such as getting player's mouse position, converting a dimension so it'll fit to the player's screen and so on.
