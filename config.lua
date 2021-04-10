ui.config = {}

-- Do not touch this!
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

-- Defines the frequency of the hover events in milliseconds. The lower is smoother but heavier performance-wise, the higher is less smoother but less heavier.
-- Recommended to keep it as-is. 
ui.config.mouseRefreshRate = 20

-- Enables the errors and other info in the console related to UI Framework.
ui.config.consoleOutputs = true

-- Specifies the trigger bindings for onClick and onRightClick events.
-- Recommended to keep them as-is.
ui.config.pressKey = "mouse1"
ui.config.pressRightKey = "mouse2"

-- When enabled, onHover and onUnhover events are triggered only once when needed and no more. Meaning it maintains significant performance.
-- Recommended to keep it true.
ui.config.limitedHovering = true

-- Loads a library made by Simonas (USGN ID: 5537) which helps UI Framework generating auto-sized backgrounds for text objects.
-- Note: This works only with default CS2D font.
ui.config.textwidthLibrary = true
