local Row = {}
local Config = require('Game.Config')
local Grid = require('Game.Map.Grid')

-- Row.searchFor = function(options)
--     local row = options.rowNum
--     local targetName = options.targetName
--     local cb = options.cb
--     local columnAmt = Config.tiles

--     for i = 0, columnAmt, 1 do
--         local obj = Grid.matrix[row][i]

--         if(obj.info.name = targetName) then
--             cb(obj)
--         end
--     end
-- end

-- local objBehavior = require('game.behaviors.ElectricityGenerator')

-- Row.searchFor({
--     rowNum = 5,
--     targetName = 'ElectricityGenerator',
--     cb = function(target)
--         -- objBehavior.updateElectricity(target)
--     end
-- })



return Row