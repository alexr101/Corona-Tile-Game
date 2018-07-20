-- dependencies
-- Game.Config
-- Screen

local LevelBuilder = {}
local createModeBtn
local createModeTxt

local function updateText(textbox, text)
  textbox.text = text

end


local function changeCreateMode()
  if(Config.levelBuilder.createMode == 'inGrid') then
    Config.levelBuilder.createMode = 'outOfGrid'
  else
    Config.levelBuilder.createMode = 'inGrid'
  end

  updateText(createModeTxt, 'Create Mode: ' .. Config.levelBuilder.createMode)
end


LevelBuilder.initControls = function()

  local defaulTxtOptions = {
    text = "Default Text",         
    width = 220,
    font = native.systemFont,
    fontSize = 12
  }

  createModeBtn = widget.newButton({
    label = "Change \nCreate Mode",
    fontSize = 12,
    shape = "roundedRect",
    width = Screen.width/3,
    height = 40,
    cornerRadius = 2,
    fillColor = { default={.6,.6,.6,1}, over={.5,.5,.5, 1} },
    labelColor = { default={0}, over={0} },    
    onRelease = changeCreateMode
  })
  createModeBtn.anchorX = 0
  createModeBtn.anchorY = 0
  createModeBtn.x = 0
  createModeBtn.y = 0

  createModeTxt = display.newText(defaulTxtOptions)
  createModeTxt.anchorX = 0
  createModeTxt.text = "Create Mode: " .. Config.levelBuilder.createMode
  createModeTxt.x = 0
  createModeTxt.y = createModeBtn.height + 10
end

return LevelBuilder