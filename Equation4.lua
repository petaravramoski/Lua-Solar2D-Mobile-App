local composer = require("composer")
composer.recycleOnSceneChange = true
local scene = composer.newScene()

local in_rect = 0
local points = 100000
local xmin = 0
local xmax = 4
local ymin = 0
local ymax = 4

local widget = require("widget")




function scene:create(event)

    local sceneGroup = self.view

    --bg = Background grey rect
    local bg = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth,
        display.actualContentHeight)
    bg:setFillColor(0.12, 0.12, 0.12)

    --TB = Top Bar, grey bar on top holding the equation details
    local TB = display.newRect(160, -23.5, 319, 83)
    TB:setFillColor(0.23, 0.23, 0.23)


    local X1Text = display.newText("X axis MIN: " .. xmin, 180, 37, FONT) -- X MIN TEXT
    local X2Text = display.newText("X axis MAX: " .. xmax, 180, 55, FONT) -- X MAX TEXT
    local Y1Text = display.newText("Y axis MIN: " .. ymin, 53, 37, FONT) -- Y MIN TEXT
    local Y2Text = display.newText("Y axis MAX: " .. ymax, 55, 55, FONT) -- Y MAX TEXT
    local xaxis = display.newText("x", 160, 347, FONT) -- text to display letter x for x axis
    local yaxis = display.newText("y", 22, 220, FONT) -- text to dusplay letter y for y axis

    local E1 = display.newText("i = 15 * (x ^ 3) + 21 * (x ^ 2) + 41 * x + 3", 150, -33, FONT) -- Code to dispaly first part of equation
    local E2 = display.newText("result1 = i ^ (1 / 4)", 150, -15, FONT) -- code to display second part of equation
    local E3 = display.newText("FINAL = result1 * 2.718 ^ (-0.5 * x)", 150, 5, FONT) -- code to display third part of equation

    --Group for rectangle that holds the points
    local myGroupD = display.newGroup()
    -- Rectangle that holds the points in equation scenes
    local myRect = display.newRect(50, 50, 250, 250)
    myRect:setFillColor(0, 0.5, 0.5)
    myGroupD:insert(myRect)
    myGroupD.x = 112
    myGroupD.y = 156

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
    sceneGroup:insert(button)
    sceneGroup:insert(myGroupD)
    sceneGroup:insert(X1Text)
    sceneGroup:insert(X2Text)
    sceneGroup:insert(Y1Text)
    sceneGroup:insert(Y2Text)
    sceneGroup:insert(xaxis)
    sceneGroup:insert(yaxis)
    sceneGroup:insert(E1)
    sceneGroup:insert(E2)
    sceneGroup:insert(E3)

end

-- show()
function scene:show(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

        myGroup4 = display.newGroup() --Group that holds the points displayed by calculation

        local function f(x)
            local inner = 15 * (x ^ 3) + 21 * (x ^ 2) + 41 * x + 3
            local res = inner ^ (1 / 4)
            local res2 = res * 2.718 ^ (-0.5 * x)
            return res2
        end

        for i = 1, points do

            x = xmin + (xmax - xmin) * math.random()
            y = ymin + (ymax - ymin) * math.random()

            if y < f(x) then
                dot4 = display.newCircle(x * 62.3, y * 62, 0.5) -- displaying points with display.newCircle ( x and y scaleing in brackets)
                myGroup4:insert(dot4) --inserting points into group
                in_rect = in_rect + 1 --Counting the points inserted into rect under curve
            end
        end

        local result4 = (in_rect / points) * 16 -- calculating the area under the curve
        local RE4 = (result4 - 5.7) / 5.7 -- calculating the relative error
        local REP4 = (math.abs(RE4) / 5.7) * 100 -- calculating the relative error percentage

        myGroup4.xScale = -1
        myGroup4.x = 37.6
        myGroup4.y = 330
        myGroup4.rotation = 179.9

        --TEXT OPTIONS THAT WILL DISPLAY RELATIVE ERROR
        local toptions =
        {
            text = "Calculated Area: " .. result4,
            x = 160, y = 375,
            font = FONT,
        }
        --TEXT OPTIONS FOR TEXT THAT WILL DISPLAY CALCULATED AREA
        local t2options =
        {
            text = "Relative Error: " .. RE4,
            x = 160, y = 395,
            font = FONT,
        }
        --TEXT OPTIONS FOR TEXT THAT WILL DISPLAY RELATIVE ERROR PERCENTAGE
        local t3options =
        {
            text = "Relative Error %: " .. REP4,
            x = 160, y = 415,
            font = FONT,
        }

        TextE4 = display.newText(toptions) -- E1 = Ewuation 1
        TextRE4 = display.newText(t2options) -- RE = RELATIVE ERROR
        TextREP4 = display.newText(t3options) -- REP = Relative Error Percentage
        p4text = display.newText("Points in Area: " .. in_rect, 230, 500, FONT)

    elseif (phase == "did") then

    end
    sceneGroup:insert(myGroup4) -- INSERTING the points that will display
    sceneGroup:insert(TextE4) -- INSERTING the text that displays the calculated area
    sceneGroup:insert(TextRE4) -- INSERTING the text that displays Relatve Error
    sceneGroup:insert(TextREP4) -- INSERTING the text that display the Relative Error percentage
    sceneGroup:insert(p4text) -- Text for points in area
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
