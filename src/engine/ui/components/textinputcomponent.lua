---@class TextInputComponent : AbstractMenuItemComponent
---@overload fun(...) : TextInputComponent
local TextInputComponent, super = Class(AbstractMenuItemComponent)

function TextInputComponent:init(options)
    options = options or {}
    super.init(self, 0, 0, FillSizing(), FixedSizing(options.height or 32))
    self.input = {options.starting or ""}
    self.options = options
end

function TextInputComponent:onSelected()
    Assets.playSound("ui_select")
    self:setFocused(true)

    TextInput.attachInput(self.input, self.options.input_settings or {
        enter_submits = true,
        multiline = false,
        clear_after_submit = false
    })
    TextInput.submit_callback = function()
        self:setFocused(false)
        TextInput.endInput()
        Input.clear("return")
        Assets.playSound("ui_select")
    end
end

function TextInputComponent:draw()
    super.draw(self)

    love.graphics.setLineWidth(2)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.line(0, self.height, self.width, self.height)

    local font = Assets.getFont(self.options.font or "main")

    if self:isFocused() then
        TextInput.draw({
            x = 0,
            y = 0,
            font = font,
            print = function(text, x, y) love.graphics.print(text, x, y) end,
        })
    else
        love.graphics.setFont(font)
        love.graphics.print(self.input[1], 0, 0)
    end
end

return TextInputComponent
