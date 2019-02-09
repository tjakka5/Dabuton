io.stdout:setvbuf('no') --print console messages in real time
button = require "dabuton" --Require the library so we can use it.

function love.load()
	--Setting up a table called flags with data for our button1
	local flags1 = {
		--Position and size
		xPos = 0,
		yPos  = 0,
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
			print("hai1")
		end,
	}

	--Setting up a table called flags with data for our button2
	local flags2 = {
		--Position and size
		xPos = 0,
		yPos  = 0,
		width = 100,
		height = 50,

		--Color for the button
		color = {
			red = 0,
			green = 255,
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
			print("hai2")
		end,
	}

	id1 = button.spawn(flags1)	-- Spawn button1
	id2 = button.spawn(flags2)	-- Spawn button2
	id1:setPos(200, 200)
	id2:setPos(200, 250)
end

function love.update(dt)
	button.update()	-- Update all buttons
end

function love.draw()
	button.draw()	-- Draw all buttons
end
