local composer = require("composer")
composer.recycleOnSceneChange = true
local scene = composer.newScene()

--variables below for the equation calculations
local in_rect = 0
local points = 10000
local xmin = 0
local xmax = 5
local ymin = 0
local ymax = 5

local widget = require("widget")


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
    local TBText = display.newText("Equation 1: y = x", 160, -24, FONT)

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

function scene:show(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        myGroup = display.newGroup() --Group that holds the points displayed by calculation
        for i = 1, points do
            x = xmin + (xmax - xmin) * math.random()
            y = ymin + (ymax - ymin) * math.random()
            if y < x then
                dot = display.newCircle(x * 49.8, y * 49.8, 1) -- displaying points with display.newCircle ( x and y scaleing in brackets)
                myGroup:insert(dot) --inserting points into group
                in_rect = in_rect + 1 --Counting the points inserted into rect under curve
            end
        end
        local result1 = (in_rect / points) * 25 -- calculating the area under the curve
        local RE = (result1 - 12.5) / 12.5 -- calculating the relative error
        local REP = (math.abs(RE) / 12.5) * 100 -- calculating the relative error percentage
        myGroup.x = 285
        myGroup.y = 80
        myGroup.rotation = 89.8


        --TEXT OPTIONS THAT WILL DISPLAY RELATIVE ERROR
        local t2options =
        {
            text = "Relative Error: " .. RE,
            x = 160, y = 395,
            font = FONT,
        }
        --TEXT OPTIONS FOR TEXT THAT WILL DISPLAY CALCULATED AREA
        local toptions =
        {
            text = "Calculated Area: " .. result1,
            x = 160, y = 375,
            font = FONT,
        }
        --TEXT OPTIONS FOR TEXT THAT WILL DISPLAY RELATIVE ERROR PERCENTAGE
        local t3options =
        {
            text = "Relative Error %: " .. REP,
            x = 160, y = 415,
            font = FONT,
        }

        TextE1 = display.newText(toptions) -- E1 = Ewuation 1
        TextRE = display.newText(t2options) -- RE = RELATIVE ERROR
        TextREP = display.newText(t3options) -- REP = Relative Error Percentage
        p1text = display.newText("Points in Area: " .. in_rect, 230, 500, FONT)

    elseif (phase == "did") then

    end
    sceneGroup:insert(myGroup) -- INSERTING the points that will display
    sceneGroup:insert(TextE1) -- INSERTING the text that displays the calculated area
    sceneGroup:insert(TextRE) -- INSERTING the text that displays Relatve Error
    sceneGroup:insert(TextREP) -- INSERTING the text that display the Relative Error percentage
    sceneGroup:insert(p1text) -- Text for points in area


end

-- hide()
function scene:hide(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then


    elseif (phase == "did") then

    end

end

-- destroy()
function scene:destroy(event)

    local sceneGroup = self.view

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
