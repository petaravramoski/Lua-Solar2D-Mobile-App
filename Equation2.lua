local composer = require("composer")
composer.recycleOnSceneChange = true
local scene = composer.newScene()

local in_rect = 0
local points = 50000
local xmin = -2
local xmax = 2
local ymin = 0
local ymax = 4

local widget = require("widget")

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)

    local sceneGroup = self.view

    --bg = Background grey rect
    local bg = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth,
        display.actualContentHeight)
    bg:setFillColor(0.12, 0.12, 0.12)

    --TB = Top Bar, grey bar on top holding the equation details
    local TB = display.newRect(160, -23.5, 319, 40)
    TB:setFillColor(0.23, 0.23, 0.23)

    --text in TB that shows the equation
    local TBText = display.newText("Equation 2: y = x^2", 160, -24, FONT)

    local X1Text = display.newText("X axis MIN: " .. xmin, 180, 10, FONT) -- X MIN TEXT
    local X2Text = display.newText("X axis MAX: " .. xmax, 180, 30, FONT) -- X MAX TEXT
    local Y1Text = display.newText("Y axis MIN: " .. ymin, 53, 10, FONT) -- Y MIN TEXT
    local Y2Text = display.newText("Y axis MAX: " .. ymax, 55, 30, FONT) -- Y MAX TEXT
    local xaxis = display.newText("x", 160, 347, FONT) -- text to display letter x for x axis
    local yaxis = display.newText("y", 22, 220, FONT) -- text to dusplay letter y for y axis

    --Group for rectangle that holds the points
    local myGroupB = display.newGroup()
    -- Rectangle that holds the points in equation scenes
    local myRect = display.newRect(50, 50, 250, 250)
    myRect:setFillColor(0, 0.5, 0.5)
    myGroupB:insert(myRect)
    myGroupB.x = 112
    myGroupB.y = 156

    local function switch(event)

        local function doSwitch()
            composer.gotoScene("Homepage")
        end

        timer.performWithDelay(100, doSwitch)
    end

    -- button options for back button in the equation scenes
    local buttonOptions = {
        fillColor = { default = { 0, 0.5, 0.5 }, over = { 0, 0.6, 0.6 } },
        font = FONT,
        width = 80,
        height = 45,
        label = "Back",
        labelColor = { default = { 1, 1, 1 } },
        left = 10, top = 460,
        shape = "roundedrect",
        onRelease = switch,
    }

    local button = widget.newButton(buttonOptions)

    sceneGroup:insert(bg)
    sceneGroup:insert(TB)
    sceneGroup:insert(TBText)
    sceneGroup:insert(button)
    sceneGroup:insert(myGroupB)
    sceneGroup:insert(X1Text)
    sceneGroup:insert(X2Text)
    sceneGroup:insert(Y1Text)
    sceneGroup:insert(Y2Text)
    sceneGroup:insert(xaxis)
    sceneGroup:insert(yaxis)

end

-- show()
function scene:show(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        myGroup2 = display.newGroup() --Group that holds the points displayed by calculation

        function f(x) --function that holds the cruve calculation
            local ret = x ^ 2 --cruve calculation
            return ret --returning cruve
        end

        for i = 1, points do
            x = xmin + (xmax - xmin) * math.random()
            y = ymin + (ymax - ymin) * math.random()
            if y < f(x) then
                dot2 = display.newCircle(x * 62, y * 62, 0.8) -- displaying points with display.newCircle ( x and y scaleing in brackets)
                myGroup2:insert(dot2) --inserting points into group
                in_rect = in_rect + 1 --Counting the points inserted into rect under curve
            end
        end
        local result2 = (in_rect / points) * 16 -- calculating the area under the curve
        local RE2 = (result2 - 5.3) / 5.3 -- calculating the relative error
        local REP2 = (math.abs(RE2) / 5.3) * 100 -- calculating the relative error percentage
        myGroup2.x = 161.7
        myGroup2.y = 329.3
        myGroup2.rotation = 180

        --TEXT OPTIONS FOR TEXT THAT WILL DISPLAY CALCULATED AREA
        local toptions =
        {
            text = "Calculated Area: " .. result2,
            x = 160, y = 375,
            font = FONT,
        }
        --TEXT OPTIONS THAT WILL DISPLAY RELATIVE ERROR
        local t2options =
        {
            text = "Relative Error: " .. RE2,
            x = 160, y = 395,
            font = FONT,
        }
        --TEXT OPTIONS FOR TEXT THAT WILL DISPLAY RELATIVE ERROR PERCENTAGE
        local t3options =
        {
            text = "Relative Error %: " .. REP2,
            x = 160, y = 415,
            font = FONT,
        }

        TextE2 = display.newText(toptions) -- E2 = Equation 2
        TextRE2 = display.newText(t2options) -- RE = RELATIVE ERROR
        TextREP2 = display.newText(t3options) -- REP = Relative Error Percentage
        p2text = display.newText("Points in Area: " .. in_rect, 230, 500, FONT) -- TEXT for points in area

    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen

    end
    sceneGroup:insert(myGroup2) -- INSERTING the points that will display
    sceneGroup:insert(TextE2) -- INSERTING the text that displays the calculated area
    sceneGroup:insert(TextRE2) -- INSERTING the text that displays Relatve Error
    sceneGroup:insert(TextREP2) -- INSERTING the text that display the Relative Error percentage
    sceneGroup:insert(p2text) -- INSERTING text tjat will display how many points in area
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
