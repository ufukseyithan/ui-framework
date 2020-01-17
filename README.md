# UI Framework
UI Framework, as its name signifies, is a framework which assists you creating UIs with a small structure logic for a game called [CS2D](http://www.cs2d.com/). It is a lot easier to create buttons, texts, images and subsequently interacting with them now.

## Installation
The installation is quite easy. Just create a new folder in `sys/lua/` called "ui-framework" and put all the files in there. Dofile the `main.lua` and you're good to go! Although you can name the folder you are going to create like however you want, as long as you change *ui.path* in `main.lua`.

## Features

### Objects
You can create objects such as buttons, texts, images and even windows only with a single function. Every function that is to create an object, returns object’s data (sort of an ID). This implies you can save their data to variables, and then use them to change their properties or even tie new events to them.
```Lua
local object = ui.objects.createImage(id, path, x, y, style)
```

Create a Button object whose background will be auto-sized by its text width (has padding 10):
```Lua
local button = ui.objects.createButton(id, "Button", x, y, nil, nil, true, 10, {
    background = {
        color = {155, 155, 155},
        alpha = 0.5
    }
})
```
In order this to work, *textwidthLibrary* in `config.lua` should be set to true (default). 

### Styles
Every object may have a style defining their visual look. The size or the colour of a text, the opacity or the scale of an image; those are all very effortless to change now. Having an extra table with all the style information in it as usually a last parameter when creating an object, makes it happen. Moreover, you can even create style patterns and use them on specific objects. 
```Lua
-- Setting a style right after creating an object
local object2 = ui.objects.createImage(id, path, x, y, {
    color = {255, 0, 0}
})

-- Creating a pattern
ui.style.new("red", {
    color = {255, 0, 0}
})

-- Using the pattern on an object
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
local button = ui.objects.createButton(id, "Click", x, y, 32, 32, nil, nil, style)
button.onClick = function()
    button.setStyle({
        textColor = "255000000"
    })
end
 ```
### Misc
The framework includes several functions that may help you while creating UIs. Such as getting player's mouse position, converting a dimension so it'll fit to the player's screen and so on.
