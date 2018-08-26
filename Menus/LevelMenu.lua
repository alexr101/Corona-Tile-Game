LevelMenu = {}
local CustomWidgets = require('UI.CustomWidgets')
local widget = require('widget')
local composer = require( "composer" )
local State = require('Game.State')


LevelMenu.initControls = function()
    LevelMenu.initMenuBtn()
    LevelMenu.initRestartLevelBtn()
end

LevelMenu.initMenuBtn = function()
    local resetLevelBtn = CustomWidgets.newBtn({
        label ='Reset Level',
        x = 0,
        y = 0,
        onRelease = function()
            composer.gotoScene( "Level1", "fade", 500 )
            composer.removeScene( "Level1", "fade", 500 )
        end
    })
    -- State.sceneGroup:insert( resetLevelBtn )
end

LevelMenu.initRestartLevelBtn = function()
    local menuBtn = CustomWidgets.newBtn({
        label ='Menu',
        x = 100,
        y = 0,
        onRelease = function()
            -- composer.gotoScene( "Level1", "fade", 500 )
            -- composer.removeScene( "Level1", "fade", 500 )
        end
    })
    -- State.sceneGroup:insert( menuBtn )
end

return LevelMenu