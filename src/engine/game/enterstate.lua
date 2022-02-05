local EnteringGame = {}

function EnteringGame:init()
    self.fader_alpha = 0
    self.save_id = -1
    self.prior_state = {}
end

function EnteringGame:enter(from, save_id)
    self.prior_state = from
    self.save_id = save_id
end

function EnteringGame:update(dt)
    --self.prior_state:update(dt)
    self.fader_alpha = self.fader_alpha + (dt * 4)

    if (not self.mod_loading) and self.fader_alpha >= 1 then
        Gamestate.switch(Kristal.States["Game"], self.save_id, true)
    end
end

function EnteringGame:draw()
    love.graphics.clear()
    self.prior_state:draw()
    love.graphics.setColor(0, 0, 0, self.fader_alpha)
    love.graphics.rectangle("fill", 0, 0, 640, 480)
    love.graphics.setColor(1, 1, 1, 1)
end

return EnteringGame