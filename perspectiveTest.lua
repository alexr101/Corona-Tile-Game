--------------------------------------------------------------------------------
-- Perspective Demo
--------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

--------------------------------------------------------------------------------
-- Localize
--------------------------------------------------------------------------------
local require = require

local perspective = require("Libraries.Perspective")

local function forcesByAngle(totalForce, angle)
    local forces = {}
    local radians = -math.rad(angle)
    forces.x = math.cos(radians) * totalForce
    forces.y = math.sin(radians) * totalForce
    return forces
end

--------------------------------------------------------------------------------
-- Build Camera
--------------------------------------------------------------------------------
local camera = perspective.createView()

--------------------------------------------------------------------------------
-- Build Player
--------------------------------------------------------------------------------
local player = display.newPolygon(0, 0, {-50, -30, -50, 30, 50, 0})
player.strokeWidth = 6
player:setFillColor(0, 0, 0, 0)
player.anchorX = 0.2 -- Slightly more "realistic" than center-point rotating

-- Some various movement parameters
player.angularVelocity = 0 -- Speed at which player rotates
player.angularAcceleration = 1.05 -- Angular acceleration rate
player.angularDamping = 0.9 -- Angular damping rate
player.angularMax = 10 -- Max angular velocity
player.moveSpeed = 0 -- Current movement speed
player.linearDamping = 0 -- Linear damping rate
player.linearAcceleration = 1.05 -- Linear acceleration rate
player.linearMax = 10 -- Max linear velocity

camera:add(player, 1) -- Add player to layer 1 of the camera

--------------------------------------------------------------------------------
-- "Scenery"
--------------------------------------------------------------------------------
local scene = {}
for i = 1, 100 do
    scene[i] = display.newCircle(0, 0, 10)
    scene[i].x = math.random(display.screenOriginX, display.contentWidth * 3)
    scene[i].y = math.random(display.screenOriginY, display.contentHeight)
    scene[i]:setFillColor(math.random(100) * 0.01, math.random(100) * 0.01, math.random(100) * 0.01)
    camera:add(scene[i], math.random(2, camera:layerCount()))
end

camera:setParallax(1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3) -- Here we set parallax for each layer in descending order

--------------------------------------------------------------------------------
-- Movement Buttons
--------------------------------------------------------------------------------
local m = {}
m.result = "none"
m.rotate = {}

m.rotate.left = display.newRect(0, 0, 60, 60)
m.rotate.left.x = display.screenOriginX + m.rotate.left.contentWidth + 10
m.rotate.left.y = display.contentHeight - m.rotate.left.contentHeight - 10
m.rotate.left.result = "rotate:left"

m.rotate.right = display.newRect(0, 0, 60, 60)
m.rotate.right.x = display.contentWidth - display.screenOriginX - m.rotate.right.contentWidth - 10
m.rotate.right.y = display.contentHeight - m.rotate.right.contentHeight - 10
m.rotate.right.result = "rotate:right"

m.forward = display.newRect(0, 0, display.contentWidth * 0.75, 60)
m.forward.x = display.contentCenterX
m.forward.y = display.contentHeight - m.forward.contentHeight - 10
m.forward.result = "move"

--------------------------------------------------------------------------------
-- Touch Movement Buttons
--------------------------------------------------------------------------------
function m.touch(event)
    local t = event.target

    if "began" == event.phase then
        display.getCurrentStage():setFocus(t)
        t.isFocus = true
        m.result = t.result

        if t.result == "rotate:left" then
            player.angularVelocity = -2
        elseif t.result == "rotate:right" then
            player.angularVelocity = 2
        elseif t.result == "move" then
            player.moveSpeed = 2
        end
    elseif t.isFocus then
        if "moved" == event.phase then
        elseif "ended" == event.phase then
            display.getCurrentStage():setFocus(nil)
            t.isFocus = false
            m.result = "none"
        end
    end
end

m.rotate.left:addEventListener("touch", m.touch)
m.rotate.right:addEventListener("touch", m.touch)
m.forward:addEventListener("touch", m.touch)

--------------------------------------------------------------------------------
-- Runtime Loop
--------------------------------------------------------------------------------
local function enterFrame(event)
    if m.result == "rotate:left" then
        player.angularVelocity = player.angularVelocity * player.angularAcceleration
        player.angularVelocity = math.max(player.angularVelocity, -player.angularMax)
        player.moveSpeed = player.moveSpeed * player.linearDamping
    elseif m.result == "rotate:right" then
        player.angularVelocity = player.angularVelocity * player.angularAcceleration
        player.angularVelocity = math.min(player.angularVelocity, player.angularMax)
        player.moveSpeed = player.moveSpeed * player.linearDamping
    elseif m.result == "move" then
        player.moveSpeed = player.moveSpeed * player.linearAcceleration
        player.moveSpeed = math.min(player.moveSpeed, player.linearMax)
        player.angularVelocity = player.angularVelocity * player.angularDamping
    elseif m.result == "none" then
        player.angularVelocity = player.angularVelocity * player.angularDamping
        player.moveSpeed = player.moveSpeed * player.linearDamping
    end

    local forces = forcesByAngle(player.moveSpeed, 360 - player.rotation)
    player:translate(forces.x, forces.y)

    player:rotate(player.angularVelocity)
end

--------------------------------------------------------------------------------
-- Add Listeners
--------------------------------------------------------------------------------
Runtime:addEventListener("enterFrame", enterFrame)

camera.damping = 10 -- A bit more fluid tracking
camera:setFocus(player) -- Set the focus to the player
camera:track() -- Begin auto-tracking

local composer = require("composer")
composer.removeScene("Menu")
local scene = composer.newScene()

function scene:create(event)
    -- Called when the scene's view does not exist.
    --
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
    local sceneGroup = self.view


    -- AppState.currentGame.sceneGroup:insert(player)
    -- sceneGroup:insert( player )
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then
    -- Called when the scene is now on screen
    --
    -- INSERT code here to make the scene come alive
    -- e.g. start timers, begin animation, play audio, etc.
    end
end

function scene:hide(event)
    local sceneGroup = self.view

    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
        physics.stop()
    elseif phase == "did" then
    -- Called when the scene is now off screen
    end
end

function scene:destroy(event)
    -- Called prior to the removal of scene's "view" (sceneGroup)
    --
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc.
    local sceneGroup = self.view

    package.loaded[physics] = nil
    physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

-----------------------------------------------------------------------------------------

return scene
