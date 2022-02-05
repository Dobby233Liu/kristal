local EnteringGame = {}

function EnteringGame:init()
    self.mod = {}
    self.prior_state = {}
    self.fader_alpha = 0
    self.save_id = -1
    self.done = false
end

function EnteringGame:enter(from, mod, save_id)
    self.mod = mod
    self.prior_state = from
    self.fader_alpha = 0
    self.save_id = save_id
    self.done = false
    Kristal.loadModAssets(self.mod.id, function()
        self.done = true
    end)
end

function EnteringGame:update(dt)
    self.prior_state:update(dt)

    self.fader_alpha = self.fader_alpha + (dt / 0.25)

    if self.fader_alpha >= 1 and self.done then
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