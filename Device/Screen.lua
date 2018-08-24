-----------------------------------------------------------------------------------------
--
-- DEVICE SCREEN PROPERTIES AND HELPER FUNCTIONS
--
-----------------------------------------------------------------------------------------


local scene = {}

local Config = require('Game.Config')

scene.width = display.actualContentWidth
scene.height = display.actualContentHeight
scene.halfW = display.contentCenterX
scene.halfH = display.contentCenterY
scene.originX = display.screenOriginX
scene.originY = display.screenOriginY
scene.actualContentWidth = display.actualContentWidth
scene.actualContentHeight = display.actualContentHeight

return scene