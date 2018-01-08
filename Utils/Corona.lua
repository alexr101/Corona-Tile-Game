local swapImage = function(oldImage, imageFile, width, height)
    local newImage = display.newImageRect(imageFile, width, height)

    newImage.x = oldImage.x
    newImage.y = oldImage.y
    oldImage:removeSelf()
    oldImage = nil

    return newImage
end