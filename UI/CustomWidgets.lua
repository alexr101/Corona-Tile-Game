local CustomWidgets = {}

local widget = require('widget')

CustomWidgets.newBtn = function(options)
    btn = widget.newButton({
        label = options.label,
        fontSize = 12,
        shape = "roundedRect",
        width = Screen.width/3,
        height = 40,
        cornerRadius = 2,
        fillColor = { default={.6,.6,.6,1}, over={.5,.5,.5, 1} },
        labelColor = { default={0}, over={0} },    
        onRelease = function()
            options.onRelease()
            print('reset level');
        end
    })
    btn.anchorX = 0
    btn.anchorY = 0
    btn.x = options.x
    btn.y = options.y

    return btn
end


return CustomWidgets