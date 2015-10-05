# Dabuton
A simple button library for Love2d.


Dabuton is a library to make basic buttons in Love2d.
These buttons can have specific specifications such as:

* Position and Size
* Colors and alpha
* Borders
* 4 functions to determine a button's functionality

# Setting up a simple button that prints "hai"
```lua
require "dabuton" --Require the library so we can use it.

function love.load()
	local flags = {	--Setting up a table called flags with data for our button
		xPos = 10,
		yPos  = 10,
		width = 100,
		height = 50,
		--Position and size
		
		color = {
			red = 0,
			green = 0,
			blue = 255,
		},
		--Color for the button
		
		border = {
			width = 2,
			red = 0,
			green = 0,
			blue = 0,
		},
		--Settings for the border
		
		onClick = {				--The onclick function; decided what happends then the button gets clicked
			func = print,		--When clicked, call the function print...
			args = {"hai"},		--...With the argument "hai"
		},
	}
	
	id = button.spawn(flags)	--Spawn the button
end

function love.update(dt)
	button.update()	--Update all buttons
end

function love.draw()
	button.draw()	--Draw all buttons
end
```

And just like that we have a very simple button.

For more advanced functionality you can mess around with the flags and functions listed below:

#Flags
```lua
xPos, yPos --Position of the button
width, heigth --Size of the button

color = {	--Color and alpha of the button
	red,
	green,
	blue,
	alpha,
}

border = {	--OPTIONAL, Color, alpha and size of the border
	red,
	green,
	blue,
	alpha,
	width,
}

onClick = {	--OPTIONAL, Calls the function when the button is clicked.
	func,
	args,
}

onRelease = {	--OPTIONAL, Calls the function when the button is released.	!NOTE!: Requires onClick
	func,
	args,
}

onHover = {	--OPTIONAL, Calls the function when the button is hovered over.
	func,
	args,
}

onBlur = {	--OPTIONAL, Calls the function when the button is not hovered over anymore. !NOTE!: Requires onHover
	func,
	args,
}
```

#Functions
```lua
button.spawn(flags)	--Takes a table with flags and spawns a button based on that. Returns the ID of the spawned button

button.update()	--Required to update all the buttons

button.draw()	--Required to draw all the buttons


button.onClick(id)	--Used to manually call the button onClick command

button.onRelease(id)	--Used to manually call the button onRelease command

button.onHover(id)	--Used to manually call the button onHover command

button.onBlur(id)		--Used to manually call the button onBlur command

button.setPos(id, x, y)		--Set the button position

button.setSize(id, width, height)	--Set the button size

button.setColor(id, r, g, b, a)	--Set the button color

button.setBorder(id, enabled, width, r, g, b, a)	--Set the border, width, and color

button.setOnClick(id, func, args)	--Set the onClick command

button.setOnRelease(id, func, args)	--Set the onRelease command

button.setOnHover(id, func, args)	--Set the onHover command

button.setOnBlur(id, func, args)	--Set the onBlur command

button.setVisibility(id, bool)	--Makes the button visible or invisible

button.setActivity(id, bool, reset)	--Makes the button active or inactive. If reset is true it will also call the button onRelease and onBlur to reset it.
```
