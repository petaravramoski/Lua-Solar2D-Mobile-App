local composer = require("composer")
composer.recycleOnSceneChange = true
local scene = composer.newScene()

local in_rect = 0
local points = 50000
local xmin = -2
local xmax = 5
local ymin = 0
local ymax = 48


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
    local TBText = display.newText("Equation 3: y = -x ^ 3 + 6 * x ^ 2 - x + 17", 160, -24, FONT)

    local X1Text = display.newText("X axis MIN: " .. xmin, 180, 10, FONT) -- X MIN TEXT
    local X2Text = display.newText("X axis MAX: " .. xmax, 180, 30, FONT) -- X MAX TEXT
    local Y1Text = display.newText("Y axis MIN: " .. ymin, 53, 10, FONT) -- Y MIN TEXT
    local Y2Text = display.newText("Y axis MAX: " .. ymax, 60, 30, FONT) -- Y MAX TEXT
    local xaxis = display.newText("x", 160, 385, FONT) -- text to display letter x for x axis
    local yaxis = display.newText("y", 100, 220, FONT) -- text to dusplay letter y for y axis

    --Group for rectangle that holds the points
    local myRectG3 = display.newGroup()
    -- Rectangle that holds the points in equation scenes
    local myRect = display.newRect(58, 51.9, 94.3, 324.3)
    myRect:setFillColor(0, 0.5, 0.5)
    myRectG3:insert(myRect)
    myRectG3.x = 105
    myRectG3.y = 159

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
        left = 10, top = 475,
        shape = "roundedrect",
        onRelease = switch,
    }

    local button = widget.newButton(buttonOptions)

    sceneGroup:insert(bg)
    sceneGroup:insert(TB)
    sceneGroup:insert(TBText)
    sceneGroup:insert(button)
    sceneGroup:insert(myRectG3)
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
        myGroup3 = display.newGroup() --Group that holds the points displayed by calculation

        local function f(x) --function that holds the cruve calculation
            local ret = -x ^ 3 + 6 * x ^ 2 - x + 17 --cruve calculation
            return ret --returning cruve
        end

        for i = 1, points do
            x = xmin + (xmax - xmin) * math.random()
            y = ymin + (ymax - ymin) * math.random()
            if y < f(x) then
                dot3 = display.newCircle(x * 13, y * 6.7, 0.5) -- displaying points with display.newCircle ( x and y scaleing in brackets)
                myGroup3:insert(dot3) --inserting points into group
                in_rect = in_rect + 1 --Counting the points inserted into rect under curve
            end
        end
        local result3 = (in_rect / points) * 336 -- calculating the area under the curve
        local RE3 = (result3 - 222) / 222 -- calculating the relative error
        local REP3 = (math.abs(RE3) / 222) * 100 -- calculating the relative error percentage

        myGroup3.xScale = -1 -- xScale - 1 so it can invert the graph produced by the points to face the right way
        myGroup3.x = 143.3
        myGroup3.y = 370.5
        myGroup3.rotation = 180

        --TEXT OPTIONS FOR TEXT THAT WILL DISPLAY CALCULATED AREA
        local toptions =
        {
            text = "Calculated Area: " .. result3,
            x = 160, y = 418,
            font = FONT,
        }
        --TEXT OPTIONS THAT WILL DISPLAY RELATIVE ERROR
        local t2options =
        {
            text = "Relative Error: " .. RE3,
            x = 160, y = 438,
            font = FONT,
        }
        --TEXT OPTIONS FOR TEXT THAT WILL DISPLAY RELATIVE ERROR PERCENTAGE
        local t3options =
        {
            text = "Relative Error %: " .. REP3,
            x = 160, y = 458,
            font = FONT,
        }

        TextE3 = display.newText(toptions) -- E2 = Equation 2
        TextRE3 = display.newText(t2options) -- RE = RELATIVE ERROR
        TextREP3 = display.newText(t3options) -- REP = Relative Error Percentage
        p3text = display.newText("Points in Area: " .. in_rect, 230, 500, FONT) -- TEXT for points in area

    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen

    end

    sceneGroup:insert(myGroup3) -- INSERTING the points that will display
    sceneGroup:insert(TextE3) -- INSERTING the text that displays the calculated area
    sceneGroup:insert(TextRE3) -- INSERTING the text that displays Relatve Error
    sceneGroup:insert(TextREP3) -- INSERTING the text that display the Relative Error percentage
    sceneGroup:insert(p3text) -- INSERTING text tjat will display how many points in area

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
