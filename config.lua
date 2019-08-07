ui.config = {}

--Do not touch this. Be warned!
ui.config.userPrototype = {
    mouseX = 0,
    mouseY = 0,

    objects = {
        images = {},
        texts = {},
        buttons = {},
        imageButtons = {},
        windows = {}
    }
}

--This is to check players' mouse position in milliseconds. Making it too low 
--could cause lags and frame drops yet would look more smooth.
ui.config.mouseRefreshRate = 20

--Enables the console inputs which would help you in any case.
ui.config.showConsoleInputs = true

--Specifies the key that will trigger the buttons when pressed.
--I recommend you not to touch it since many people have got used to it.
ui.config.pressKey = "mouse1"
ui.config.pressRightKey = "mouse2"

--This would change nothing unless you want your hover functions trigger everytime and not once.
--Better to leave it as "true" for performance.
ui.config.limitedHovering = true
