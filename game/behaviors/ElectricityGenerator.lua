BehaviorElectricityGenerator = {}
local Grid = require('game.map.Grid')
local Config = require('game.Config')
local ObjectGenerator = require('services.ObjectGenerator')
local Tiles = require('game.map.Tiles')

function conductElectricity(obj, direction)
    local obj = obj.node[direction]

    if(obj ~= nil and obj.info.conductsElectricity == true and obj.info.name ~= 'electricity' and obj.info.name ~= 'electricityGenerator') then
        local replaceOptions = {
            oldObj = obj,
            newObjInfo = ObjectGenerator.Electricity,
            x = obj.x,
            y = obj.y,
            row = obj.coordinates.row,
            column = obj.coordinates.column
        }
        
        Tiles.replace(replaceOptions)

        conductElectricity(obj, direction)
    else 
        return
    end


end

-- []-[]-[]-[]-[]


BehaviorElectricityGenerator.updateElectricity = function(obj)
    local row = obj.coordinates.row
    conductElectricity(obj, 'right')
    conductElectricity(obj, 'left')
    if(obj.node.right ~= nil) then
        print(row)
        print(obj.coordinates.column)
        print(obj.node.right.info.name)
    end
end


return BehaviorElectricityGenerator