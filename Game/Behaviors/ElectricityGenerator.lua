BehaviorElectricityGenerator = {}
local Grid = require('Game.Map.Grid')
local Config = require('Game.Config')
local ObjectGenerator = require('Services.ObjectGenerator')
local Tiles = require('Game.Map.Tiles')

function conductElectricity(options)

    local State = require('Game.State')
    local RowBehavior = require('Game.Behaviors.Row')
    local direction = options.direction
    local row = options.row
    local column = options.column
    local obj

    if(Grid.matrix[row][column] ~= nil) then
        obj = Grid.matrix[row][column].node[direction]
    end

    if(direction == 'right') then
        column = column + 1
    else
        column = column - 1
    end

    if(obj ~= nil and obj.info.conductsElectricity == true and obj.info.name ~= 'ElectricityGenerator') then

        if (obj.info.name ~= 'electricity') then
            local replaceOptions = {
                newObjInfo = ObjectGenerator.Electricity,
                x = State.getColXPosition(column),
                y = RowBehavior.getYPosition(row),
                row = row,
                column = column
            }
            
            Tiles.replace(replaceOptions)
        end

        conductElectricity({
            row = row,
            column = column,
            direction = direction
        })
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