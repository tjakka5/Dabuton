io.stdout:setvbuf('no') --print console messages in real time

button = require "dabuton" --Require the library so we can use it.

function love.load()
  local flags = { --Setting up a table called flags with data for our button

    --Position and size
    xPos = 10,
    yPos  = 10,
    width = 100,
    height = 50,

    --Color for the button
    color = {
      red = 0,
      green = 0,
      blue = 255,
    },

    --Settings for the border
    border = {
      width = 2,
      red = 0,
      green = 0,
      blue = 0,
    },

    onClick = function()
      print("hai")
    end,
  }

  id = button.spawn(flags)	-- Spawn the button
  
  id:setPos(200, 200)
end

function love.update(dt)
    button.update()	-- Update all buttons
end

function love.draw()
    button.draw()	-- Draw all buttons
end
