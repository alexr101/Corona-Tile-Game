local LevelData = {}
local Config = require('Game.Config')
local File = require('Utils.File')
local json = require('json')

local mockData = {
    { 'Rock', 'Rock', 'Rock', 'Rock', 'Rock', 'Rock' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'Rock', 'EmptySpace', 'EmptySpace' }, -- 10
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'Rock', 'EmptySpace', 'EmptySpace' }, -- 20
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'Rock', 'EmptySpace', 'EmptySpace' }, -- 25
}

LevelData.getLevelData = function()
    local data

    if(Config.gridData == 'mock') then
        data = mockData
    elseif(Config.gridData == 'json') then
        local levelJson = File.read('/LevelData/' .. Config.levelBuilder.file)
        local levelData = json.decode( levelJson )
        data = levelData
    elseif(Config.gridData == 'random') then
        data = nil
    end

    return data
end

return LevelData