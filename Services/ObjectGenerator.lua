local ObjectGenerator = {}

ObjectGenerator.MineMagnet = require('Game.Blocks.MineMagnet')
ObjectGenerator.Star = require('Game.Blocks.Star')
ObjectGenerator.Electricity = require('Game.Blocks.Electricity')
ObjectGenerator.ElectricityGenerator = require('Game.Blocks.ElectricityGenerator')

ObjectGenerator.Rock = require('Game.Blocks.Rock')
ObjectGenerator.RockCrumbling = require('Game.Blocks.RockCrumbling')
ObjectGenerator.EmptySpace = require('Game.Blocks.EmptySpace')
ObjectGenerator.DebugSpace = require('Game.Blocks.DebugSpace')
ObjectGenerator.UnmovableSpace = require('Game.Blocks.UnmovableSpace')
ObjectGenerator.BounceRock = require('Game.Blocks.BounceRock')


ObjectGenerator.objectsInGridArray = {
    ObjectGenerator.EmptySpace,
    ObjectGenerator.Star,
    ObjectGenerator.Rock,
    ObjectGenerator.RockCrumbling,
    ObjectGenerator.ElectricityGenerator,
    ObjectGenerator.UnmovableSpace,
    ObjectGenerator.BounceRock

}

ObjectGenerator.objectsOutOfGridArray = {
    ObjectGenerator.MineMagnet,
}

ObjectGenerator.objectsReactive = {
    ObjectGenerator.Electricity
}

ObjectGenerator.allObjects = {
    ObjectGenerator.EmptySpace,
    ObjectGenerator.Star,
    ObjectGenerator.Rock,
    ObjectGenerator.RockCrumbling,
    ObjectGenerator.ElectricityGenerator,
    ObjectGenerator.Electricity,
    ObjectGenerator.UnmovableSpace,
    ObjectGenerator.BounceRock
}



ObjectGenerator.names = {
    ObjectGenerator.EmptySpace.name,
    ObjectGenerator.Star.name,
    ObjectGenerator.Rock.name,
    ObjectGenerator.RockCrumbling.name,
    ObjectGenerator.UnmovableSpace.name,
    ObjectGenerator.BounceRock.name,

    ObjectGenerator.ElectricityGenerator.name,
    -- ObjectGenerator.Electricity.name,
    ObjectGenerator.UnmovableSpace.name

}

ObjectGenerator.next = function(name)
    local Table = require('Utils.Table')
    local i = Table.getIndex(ObjectGenerator.names, name) + 1

    if(i > table.getn(ObjectGenerator.names) ) then
        i = 1
    end
    
    return ObjectGenerator.allObjects[i]
end

ObjectGenerator.get = function(name)
    local name = string.upper( string.sub(name, 1, 1) ) .. string.sub(name, 2, string.len(name))
    return ObjectGenerator[name]
end

ObjectGenerator.randomOutOfGrid = function()
    return ObjectGenerator.objectsOutOfGridArray[ math.random(1, table.getn(ObjectGenerator.objectsOutOfGridArray) ) ]
end

ObjectGenerator.randomInGrid = function() 
    return ObjectGenerator.objectsInGridArray[ math.random(1, table.getn(ObjectGenerator.objectsInGridArray) ) ]
end

return ObjectGenerator