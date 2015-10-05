button = {}

function button.spawn(flags)
	local xPos, yPos = flags.xPos or error("No xPos specified"), flags.yPos or error("No yPos specified")
	local width, height = flags.width or error("No width specified"), flags.height or error("No height specified")
	
	local colorRed, colorGreen, colorBlue, colorAlpha = flags.color.red or 255, flags.color.green or 255, flags.color.blue or 255, flags.color.alpha or 255
	local border, borderColorRed, borderColorGreen, borderColorBlue, borderColorAlpha = false, nil, nil, nil, nil
	if flags.border then
		border, borderWidth = true, flags.border.width or 1
		borderColorRed, borderColorGreen, borderColorBlue, borderColorAlpha = flags.border.red, flags.border.green, flags.border.blue, flags.border.alpha
	end

	local onClick = flags.onClick
	if flags.onClick then
		onClick = flags.onClick
	end

	local onRelease = nil
	if flags.onRelease then
		onRelease = flags.onRelease
	end

	local onHover = nil
	if flags.onHover then
		onHover = flags.onHover
	end

	local onBlur = nil
	if flags.onBlur then
		onBlur = flags.onBlur
	end

	table.insert(button, 1, {
			xPos = xPos,
			yPos = yPos,
			width = width,
			height = height,

			onClick = onClick,
			onRelease = onRelease,
			onHover = onHover,
			onBlur = onBlur,

			color = {
				r = colorRed, 
				g = colorGreen, 
				b = colorBlue, 
				a = colorAlpha
			},

			border = {
				enabled = border, 
				width = borderWidth, 
				color = {
					r = borderColorRed, 
					g = borderColorGreen, 
					b = borderColorBlue, 
					a = borderColorAlpha,
				},
			},
			
			flags = {
				clicking = false,
				hovering = false,
				visible = true,
				active = true,
			},
			})

	if button[1].onClick then if button[1].onClick.args[1] == "self" then button[1].onClick.args[1] = button[1] end end
	if button[1].onRelease then if button[1].onRelease.args[1] == "self" then button[1].onRelease.args[1] = button[1] end end
	if button[1].onHover then if button[1].onHover.args[1] == "self" then button[1].onHover.args[1] = button[1] end end
	if button[1].onBlur then if button[1].onBlur.args[1] == "self" then button[1].onBlur.args[1] = button[1] end end

	return button[1]
end

function button.update(dt)
	local mx, my = love.mouse.getPosition()

	for i, buttonID in ipairs(button) do
		if buttonID.flags.active then
			if love.mouse.isDown("l") and buttonID.onClick then
				if  (my + 1 > buttonID.yPos) and (my < buttonID.yPos + buttonID.height) and
		      		(mx + 1 > buttonID.xPos) and (mx < buttonID.xPos + buttonID.width) then
					
					button.onClick(buttonID)
				end
			end

			if buttonID.onRelease and buttonID.flags.clicking and not love.mouse.isDown("l") then
				button.onRelease(buttonID)
			end

			if buttonID.onHover then
				if  (my + 1 > buttonID.yPos) and (my < buttonID.yPos + buttonID.height) and
		      		(mx + 1 > buttonID.xPos) and (mx < buttonID.xPos + buttonID.width) then
					
					button.onHover(buttonID)
				end
			end

			if buttonID.onBlur and buttonID.flags.hovering then
				if (my + 1 > buttonID.yPos) and (my < buttonID.yPos + buttonID.height) and
		      		(mx + 1 > buttonID.xPos) and (mx < buttonID.xPos + buttonID.width) then
		      	else
		      		button.onBlur(buttonID)
				end
			end
		end
	end
end

function button.onClick(id)
	if id.onClick.args then
		id.onClick.func(unpack(id.onClick.args))
	else
		id.onClick.func()
	end

	id.flags.clicking = true
end

function button.onRelease(id)
	if id.onRelease.args then
		id.onRelease.func(unpack(id.onRelease.args))
	else
		id.onRelease.func()
	end

	id.flags.clicking = false
end

function button.onHover(id)
	if id.onHover.args then
		id.onHover.func(unpack(id.onHover.args))
	else
		id.onHover.func()
	end

	id.flags.hovering = true
end

function button.onBlur(id)
	if id.onBlur.args then
		id.onBlur.func(unpack(id.onBlur.args))
	else
		id.onBlur.func()
	end

	id.flags.hovering = false
end

function button.draw()
	for i, buttonID in ipairs(button) do
		if buttonID.flags.visible then
			if buttonID.border.enabled then
				love.graphics.setColor(buttonID.border.color.r, buttonID.border.color.g, buttonID.border.color.b, buttonID.border.color.a)
				love.graphics.rectangle("fill", buttonID.xPos, buttonID.yPos, buttonID.width, buttonID.height)

				love.graphics.setColor(buttonID.color.r, buttonID.color.g, buttonID.color.b, buttonID.color.a)
				love.graphics.rectangle("fill", buttonID.xPos+buttonID.border.width, buttonID.yPos+buttonID.border.width, buttonID.width-buttonID.border.width*2, buttonID.height-buttonID.border.width*2)
			else
				love.graphics.setColor(buttonID.color.r, buttonID.color.g, buttonID.color.b, buttonID.color.a)
				love.graphics.rectangle("fill", buttonID.xPos, buttonID.yPos, buttonID.width, buttonID.height)
			end
		end
	end
end

function button.setPos(id, x, y)
	id.xPos = x
	id.yPos = y
end

function button.setSize(id, width, height)
	id.width = width
	id.height = height
end

function button.setColor(id, r, g, b, a)
	id.color.r = r
	id.color.g = g
	id.color.b = b
	id.color.a = a
end

function button.setBorder(id, enabled, width, r, g, b, a)
	id.border.enabled = enabled
	if enabled then
		id.border.width = width
		id.border.color.r = r
		id.border.color.g = g
		id.border.color.b = b
		id.border.color.a = a
	end
end

function button.setOnClick(id, func, args)
	if func then
		id.onClick.func = func
		id.onClick.args = args
	else
		id.onClick = nil
	end
end

function button.setOnRelease(id, func, args)
	if func then
		id.onRelease.func = func
		id.onRelease.args = args
	else
		id.onRelease = nil
	end
end

function button.setOnHover(id, func, args)
	if func then
		id.onHover.func = func
		id.onHover.args = args
	else
		id.onHover = nil
	end
end

function button.setOnBlur(id, func, args)
	if func then
		id.onBlur.func = func
		id.onBlur.args = args
	else
		id.onBlur = nil
	end
end

function button.setVisibility(id, bool)
	id.flags.visible = bool
end

function button.setActivity(id, bool, reset)
	id.flags.active = bool
	if reset then
		if id.onRelease then button.onRelease(id) end
		if id.onBlur then button.onBlur(id) end
	end
end
