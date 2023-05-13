local composer = require("composer")

local scene = composer.newScene()

local widget = require("widget")

FONT = native.systemFontBold
TEXT_SIZE = 20

-- create()
function scene:create(event)

    local sceneGroup = self.view
    --grey backround
    local bg = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth,
        display.actualContentHeight)
    bg:setFillColor(0.12, 0.12, 0.12)


    local function switch(event)
        local function doSwitch()
            composer.gotoScene("Equation1")
        end

        timer.performWithDelay(100, doSwitch)
    end

    local function switch2(event)
        local function doSwitch()
            composer.gotoScene("Equation2")
        end

        timer.performWithDelay(100, doSwitch)
    end

    local function switch3(event)
        local function doSwitch()
            composer.gotoScene("Equation3")
        end

        timer.performWithDelay(100, doSwitch)
    end

    local function switch4(event)
        local function doSwitch()
            composer.gotoScene("Equation4")
        end

        timer.performWithDelay(100, doSwitch)
    end

    -- code for button options that take you to equation one
    local buttonOptions = {
        fillColor = { default = { 0, 0.5, 0.5 }, over = { 0, 0.6, 0.6 } },
        font = FONT,
        label = "Equation1",
        labelColor = { default = { 1, 1, 1 } },
        left = 75, top = 130,
        shape = "roundedrect",
        onRelease = switch,
    }
    -- code for button options that take you to equation two
    local buttonOptions2 = {
        fillColor = { default = { 0, 0.5, 0.5 }, over = { 0, 0.6, 0.6 } },
        font = FONT,
        label = "Equation2",
        labelColor = { default = { 1, 1, 1 } },
        left = 75, top = 220,
        shape = "roundedrect",
        onRelease = switch2,
    }
    -- code for button options that take you to equation three
    local buttonOptions3 = {
        fillColor = { default = { 0, 0.5, 0.5 }, over = { 0, 0.6, 0.6 } },
        font = FONT,
        label = "Equation3",
        labelColor = { default = { 1, 1, 1 } },
        left = 75, top = 310,
        shape = "roundedrect",
        onRelease = switch3,
    }
    -- code for button options that take you to equation four
    local buttonOptions4 = {
        fillColor = { default = { 0, 0.5, 0.5 }, over = { 0, 0.6, 0.6 } },
        font = FONT,
        label = "Equation4",
        labelColor = { default = { 1, 1, 1 } },
        left = 75, top = 400,
        shape = "roundedrect",
        onRelease = switch4,
    }

    local button = widget.newButton(buttonOptions)
    local button2 = widget.newButton(buttonOptions2)
    local button3 = widget.newButton(buttonOptions3)
    local button4 = widget.newButton(buttonOptions4)

    local text = display.newText("Calculate Area Under Curve", 165, 20, FONT, TEXT_SIZE)
    local text2 = display.newText("Using Monte Carlo Method ", 165, 50, FONT, TEXT_SIZE)
    local text3 = display.newText("Select 4 Options Below", 165, 100, FONT, TEXT_SIZE)

    --Inserting buttons into SceneGrouo
    sceneGroup:insert(bg)
    sceneGroup:insert(button)
    sceneGroup:insert(button2)
    sceneGroup:insert(button3)
    sceneGroup:insert(button4)
    sceneGroup:insert(text)
    sceneGroup:insert(text2)
    sceneGroup:insert(text3)

end

-- show()
function scene:show(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen

    end
end

-- hide()
function scene:hide(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif (phase == "did") then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end

-- destroy()
function scene:destroy(event)

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------------

return scene
