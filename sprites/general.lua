--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a1bc53702346dcf7fea262b9975d1e96:1/1$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- Electricity1
            x=85,
            y=209,
            width=79,
            height=205,

            sourceX = 6,
            sourceY = 0,
            sourceWidth = 85,
            sourceHeight = 205
        },
        {
            -- Electricity2
            x=2,
            y=209,
            width=81,
            height=205,

            sourceX = 4,
            sourceY = 0,
            sourceWidth = 85,
            sourceHeight = 205
        },
        {
            -- Electricity3
            x=2,
            y=2,
            width=85,
            height=205,

        },
        {
            -- Electricity4
            x=166,
            y=209,
            width=69,
            height=205,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 85,
            sourceHeight = 205
        },
        {
            -- Electricity5
            x=89,
            y=2,
            width=75,
            height=205,

            sourceX = 9,
            sourceY = 0,
            sourceWidth = 85,
            sourceHeight = 205
        },
        {
            -- Electricity6
            x=166,
            y=2,
            width=71,
            height=205,

            sourceX = 5,
            sourceY = 0,
            sourceWidth = 85,
            sourceHeight = 205
        },
        {
            -- Smoke1
            x=188,
            y=492,
            width=16,
            height=16,

            sourceX = 43,
            sourceY = 43,
            sourceWidth = 102,
            sourceHeight = 102
        },
        {
            -- Smoke10
            x=239,
            y=2,
            width=102,
            height=102,

        },
        {
            -- Smoke11
            x=388,
            y=2,
            width=102,
            height=102,

        },
        {
            -- Smoke12
            x=239,
            y=106,
            width=102,
            height=100,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 102,
            sourceHeight = 102
        },
        {
            -- Smoke13
            x=237,
            y=313,
            width=102,
            height=100,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 102,
            sourceHeight = 102
        },
        {
            -- Smoke14
            x=237,
            y=209,
            width=102,
            height=102,

        },
        {
            -- Smoke2
            x=268,
            y=479,
            width=24,
            height=22,

            sourceX = 39,
            sourceY = 40,
            sourceWidth = 102,
            sourceHeight = 102
        },
        {
            -- Smoke3
            x=437,
            y=259,
            width=46,
            height=42,

            sourceX = 28,
            sourceY = 31,
            sourceWidth = 102,
            sourceHeight = 102
        },
        {
            -- Smoke4
            x=334,
            y=415,
            width=52,
            height=52,

            sourceX = 25,
            sourceY = 24,
            sourceWidth = 102,
            sourceHeight = 102
        },
        {
            -- Smoke5
            x=268,
            y=415,
            width=64,
            height=62,

            sourceX = 19,
            sourceY = 20,
            sourceWidth = 102,
            sourceHeight = 102
        },
        {
            -- Smoke6
            x=188,
            y=416,
            width=78,
            height=74,

            sourceX = 11,
            sourceY = 14,
            sourceWidth = 102,
            sourceHeight = 102
        },
        {
            -- Smoke7
            x=98,
            y=416,
            width=88,
            height=84,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 102,
            sourceHeight = 102
        },
        {
            -- Smoke8
            x=2,
            y=416,
            width=94,
            height=90,

            sourceX = 3,
            sourceY = 6,
            sourceWidth = 102,
            sourceHeight = 102
        },
        {
            -- Smoke9
            x=388,
            y=106,
            width=100,
            height=98,

            sourceX = 0,
            sourceY = 3,
            sourceWidth = 102,
            sourceHeight = 102
        },
        {
            -- Star1
            x=388,
            y=206,
            width=51,
            height=51,

        },
        {
            -- Star2
            x=388,
            y=259,
            width=47,
            height=51,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 51,
            sourceHeight = 51
        },
        {
            -- Star3
            x=343,
            y=55,
            width=31,
            height=51,

            sourceX = 10,
            sourceY = 0,
            sourceWidth = 51,
            sourceHeight = 51
        },
        {
            -- Star4
            x=492,
            y=2,
            width=13,
            height=51,

            sourceX = 19,
            sourceY = 0,
            sourceWidth = 51,
            sourceHeight = 51
        },
        {
            -- Star5
            x=343,
            y=2,
            width=31,
            height=51,

            sourceX = 10,
            sourceY = 0,
            sourceWidth = 51,
            sourceHeight = 51
        },
        {
            -- Star6
            x=441,
            y=206,
            width=47,
            height=51,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 51,
            sourceHeight = 51
        },
    },
    
    sheetContentWidth = 512,
    sheetContentHeight = 512
}

SheetInfo.frameIndex =
{

    ["Electricity1"] = 1,
    ["Electricity2"] = 2,
    ["Electricity3"] = 3,
    ["Electricity4"] = 4,
    ["Electricity5"] = 5,
    ["Electricity6"] = 6,
    ["Smoke1"] = 7,
    ["Smoke10"] = 8,
    ["Smoke11"] = 9,
    ["Smoke12"] = 10,
    ["Smoke13"] = 11,
    ["Smoke14"] = 12,
    ["Smoke2"] = 13,
    ["Smoke3"] = 14,
    ["Smoke4"] = 15,
    ["Smoke5"] = 16,
    ["Smoke6"] = 17,
    ["Smoke7"] = 18,
    ["Smoke8"] = 19,
    ["Smoke9"] = 20,
    ["Star1"] = 21,
    ["Star2"] = 22,
    ["Star3"] = 23,
    ["Star4"] = 24,
    ["Star5"] = 25,
    ["Star6"] = 26,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
