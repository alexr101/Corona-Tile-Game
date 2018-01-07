BehaviorElectricityGenerator = {}
local Grid = require('game.map.Grid')
local Config = require('game.Config')
local ObjectGenerator = require('services.ObjectGenerator')
local Tiles = require('game.map.Tiles')

function conductElectricity(options)

    local direction = options.direction
    print(options.row)
    print(options.column)
    print(direction)

    local obj = Grid.matrix[options.row][options.column].node[direction]

    if(obj ~= nil and obj.info.conductsElectricity == true and obj.info.name ~= 'electricity' and obj.info.name ~= 'electricityGenerator') then
        local replaceOptions = {
            oldObj = obj,
            newObjInfo = ObjectGenerator.Electricity,
            x = obj.x,
            y = obj.y,
            row = options.row,
            column = options.column
        }
        
        Tiles.replace(replaceOptions)

        conductElectricity(obj, direction)
    else 
        return
    end


end

BehaviorElectricityGenerator.updateElectricity = function(options)
    local row = options.row
    local column = options.column

    conductElectricity({
        row = row,
        column = column,
        direction = 'right'
    })
    conductElectricity({
        row = row,
        column = column,
        direction = 'left'
    })

end


return BehaviorElectricityGenerator