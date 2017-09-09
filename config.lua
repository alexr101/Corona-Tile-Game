system.getInfo("model")

tilePositionDeviceAdjustment = 5

if ( string.sub( system.getInfo("model"), 1, 4 ) == "iPad" ) then
   application =
   {
      content =
      {
         width = 360,
         height = 480,
         scale = "letterBox",
         xAlign = "center",
         yAlign = "center",
         imageSuffix =
         {
            ["@2x"] = 2,
            ["@4x"] = 4,
         },
      },
      notification =
      {
          iphone =
          {
              types =
              {
                  "badge", "sound", "alert"
              }
          }
      }
   }
--i-phone 5, 6, 6plus
elseif ( string.sub( system.getInfo("model"), 1, 2 ) == "iP" and display.pixelHeight > 960 ) then
   application =
   {
      content =
      {
         width = 320,
         height = 568,
         scale = "letterBox",
         xAlign = "center",
         yAlign = "center",
         imageSuffix =
         {
            ["@2x"] = 2,
            ["@4x"] = 4,
         },
      },
      notification =
    {
        iphone =
        {
            types =
            {
                "badge", "sound", "alert"
            }
        }
    }
   }
tilePositionDeviceAdjustment = 52
--i-phone 4
elseif ( string.sub( system.getInfo("model"), 1, 2 ) == "iP" ) then
   application =
   {
      content =
      {
         width = 320,
         height = 480,
         scale = "letterBox",
         xAlign = "center",
         yAlign = "center",
         imageSuffix =
         {
            ["@2x"] = 2,
            ["@4x"] = 4,
         },
      },
      notification =
    {
        iphone =
        {
            types =
            {
                "badge", "sound", "alert"
            }
        }
    }
   }
elseif ( display.pixelHeight / display.pixelWidth > 1.72 ) then
   application =
   {
      content =
      {
         width = 320,
         height = 570,
         scale = "letterBox",
         xAlign = "center",
         yAlign = "center",
         imageSuffix =
         {
            ["@2x"] = 2,
            ["@4x"] = 4,
         },
      },
      notification =
    {
        iphone =
        {
            types =
            {
                "badge", "sound", "alert"
            }
        }
    }
   }
else
   application =
   {
      content =
      {
         width = 320,
         height = 512,
         scale = "letterBox",
         xAlign = "center",
         yAlign = "center",
         imageSuffix =
         {
            ["@2x"] = 2,
            ["@4x"] = 4,
         },
      },
      notification =
    {
        iphone =
        {
            types =
            {
                "badge", "sound", "alert"
            }
        }
    }
   }
end
