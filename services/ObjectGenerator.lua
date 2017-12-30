local ObjectGenerator = {}
local MineMagnet = require('game.objects.MineMagnet')
local Star = require('game.objects.Star')
local Electricity = require('game.objects.Electricity')
local ElectricityGenerator = require('game.objects.ElectricityGenerator')

local Rock = require('game.objects.Rock')
local EmptySpace = require('game.objects.EmptySpace')




local objectsInGridArray = {
    EmptySpace,
    Star,
    Electricity,
    Rock,
    ElectricityGenerator
}

local objectsOutOfGridArray = {
    MineMagnet,
}

ObjectGenerator.randomOutOfGrid = function()
    return objectsOutOfGridArray[ math.random(1, table.getn(objectsOutOfGridArray) ) ]
end


ObjectGenerator.randomInGrid = function() 
    return objectsInGridArray[ math.random(1, table.getn(objectsInGridArray) ) ]
end

return ObjectGenerator