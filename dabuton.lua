local button = {name = "Dabuton", buttons = {}}
button.__index = button

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

  local tempButton = {
    xPos = xPos,
    yPos = yPos,
    width = width,
    height = height,

    onClickAction = onClick,
    onReleaseAction = onRelease,
    onHoverAction = onHover,
    onBlurAction = onBlur,

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
	}

  setmetatable(tempButton, button)

	table.insert(button.buttons, tempButton)

	return button.buttons[#button.buttons]
end

function button:updateSelf(mx, my)
  if self.flags.active then
    if love.mouse.isDown("l") and self.onClick then
      if  (my + 1 > self.yPos) and (my < self.yPos + self.height) and (mx + 1 > self.xPos) and (mx < self.xPos + self.width) then
        self:onClick()
      end
    end

    if self.onRelease and self.flags.clicking and not love.mouse.isDown("l") then
      self:onRelease()
    end

    if self.onHover then
      if  (my + 1 > self.yPos) and (my < self.yPos + self.height) and (mx + 1 > self.xPos) and (mx < self.xPos + self.width) then
        self:onHover()
      end
    end

    if self.onBlur and self.flags.hovering then
      if (my + 1 > self.yPos) and (my < self.yPos + self.height) and (mx + 1 > self.xPos) and (mx < self.xPos + self.width) then
        else
          self:onBlur()
      end
    end
  end
end

function button.update(dt)
	local mx, my = love.mouse.getPosition()

	for i, buttonID in ipairs(button.buttons) do
		buttonID:updateSelf(mx, my)
	end
end

function button:onClick()
	if self.onClickAction then
		self.onClickAction()
	end

	self.flags.clicking = true
end

function button:onRelease()
	if self.onReleaseAction then
		self.onReleaseAction()
	end

	self.flags.clicking = false
end

function button:onHover()
	if self.onHoverAction then
		self.onHoverAction()
	end

	self.flags.hovering = true
end

function button:onBlur()
	if self.onBlurAction then
		self.onBlurAction()
	end

	self.flags.hovering = false
end

function button:drawSelf()
  if self.flags.visible then
    if self.border.enabled then
      love.graphics.setColor(self.border.color.r, self.border.color.g, self.border.color.b, self.border.color.a)
      love.graphics.rectangle("fill", self.xPos, self.yPos, self.width, self.height)

      love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
      love.graphics.rectangle("fill", self.xPos+self.border.width, self.yPos+self.border.width, self.width-self.border.width*2, self.height-self.border.width*2)
    else
      love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
      love.graphics.rectangle("fill", self.xPos, self.yPos, self.width, self.height)
    end
  end
end

function button.draw()
	for i, buttonID in ipairs(button.buttons) do
		buttonID:drawSelf()
	end
end

function button:setPos(x, y)
	self.xPos = x
	self.yPos = y
end

function button:setSize(width, height)
	self.width = width
	self.height = height
end

function button:setColor(r, g, b, a)
	self.color.r = r
	self.color.g = g
	self.color.b = b
	self.color.a = a
end

function button:setBorder(enabled, width, r, g, b, a)
	self.border.enabled = enabled
	if enabled then
		self.border.width = width
		self.border.color.r = r
		self.border.color.g = g
		self.border.color.b = b
		self.border.color.a = a
	end
end

function button:setOnClick(func)
	if func then
		self.onClickAction = func
	else
		self.onClickAction = nil
	end
end

function button:setOnRelease(func)
	if func then
		self.onReleaseAction = func
	else
		self.onReleaseAction = nil
	end
end

function button:setOnHover(func)
	if func then
		self.onHoverAction = func
	else
		self.onHoverAction = nil
	end
end

function button:setOnBlur(func)
	if func then
		self.onBlurAction = func
	else
		self.onBlurAction = nil
	end
end

function button:setVisibility(bool)
	self.flags.visible = bool
end

function button:setActivity(bool, reset)
	self.flags.active = bool
	if reset then
		if self.onRelease then self:onRelease() end
		if self.onBlur then self:onBlur() end
	end
end

return button