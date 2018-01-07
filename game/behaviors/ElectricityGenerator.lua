BehaviorElectricityGenerator = {}
local Grid = require('game.map.Grid')
local Config = require('game.Config')
local ObjectGenerator = require('services.ObjectGenerator')
local Tiles = require('game.map.Tiles')

function conductElectricity(options)

    local State = require('game.State')
    local RowBehavior = require('game.behaviors.Row')
    local direction = options.direction
    local row = options.row
    local column = options.column
    local obj

    print('row conduct:' .. options.row)
    print('column conduct:' .. options.column)
    print('direction conduct:' .. direction)

    if(Grid.matrix[row][column] ~= nil) then
        print('not nil')
        obj = Grid.matrix[row][column].node[direction]
    end

    if(direction == 'right') then
        column = column + 1
    else
        column = column - 1
    end


    if(obj ~= nil and obj.info.conductsElectricity == true and obj.info.name ~= 'electricityGenerator') then

        if (obj.info.name ~= 'electricity') then
            local replaceOptions = {
                oldObj = obj,
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
    print('row update:' .. options.row)
    print('column update:' .. options.column)

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