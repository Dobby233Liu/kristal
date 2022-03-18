local Input = {}
local self = Input

Input.key_down = {}
Input.key_pressed = {}
Input.key_released = {}

Input.lock_stack = {}


Input.aliases = {}

Input.order = {
    "down", "right", "up", "left", "confirm", "cancel", "menu"
}

function Input.getKeysFromAlias(key)
    return Input.aliases[key]
end

function Input.loadBinds(reset)
    local defaults = {
        ["up"] = {"up"},
        ["down"] = {"down"},
        ["left"] = {"left"},
        ["right"] = {"right"},
        ["confirm"] = {"z", "return"},
        ["cancel"] = {"x", "lshift", "rshift"},
        ["menu"] = {"c", "lctrl", "rctrl"},
    }

    if (reset == nil) or (reset == false) then
        if love.filesystem.getInfo("keybinds.json") then
            Utils.merge(defaults, JSON.decode(love.filesystem.read("keybinds.json")))
        end
    end

    Input.aliases = Utils.copy(defaults)
end

function Input.orderedNumberToKey(number)
    if number <= #Input.order then
        return Input.order[number]
    else
        local index = #Input.order + 1
        for name, value in pairs(Input.aliases) do
            if not Utils.containsValue(Input.order, name) then
                if index == number then
                    return name
                end
                index = index + 1
            end
        end
        return nil
    end
end

function Input.saveBinds()
    love.filesystem.write("keybinds.json", JSON.encode(Input.aliases))
end

function Input.setBind(alias, index, key)
    if key == "escape" then
        if #Input.aliases[alias] > 1 then
            table.remove(Input.aliases[alias], index)
            return true
        else
            return false
        end
    end

    local old_key = Input.aliases[alias][index]

    for aliasname, lalias in pairs(Input.aliases) do
        for keyindex, lkey in ipairs(lalias) do
            if lkey == key then
                print(key .. " is already bound to " .. aliasname)
                if index > #Input.aliases[alias] then
                    print("this is new, not allowed!!")
                    return false
                else
                    Input.aliases[aliasname][keyindex] = old_key
                end
            end
        end
    end
    Input.aliases[alias][index] = key
    return true
end

function Input.clearPressed()
    self.key_pressed = {}
    self.key_released = {}
end

function Input.clearPressedKey(key)
    if self.aliases[key] then
        for _,k in ipairs(self.aliases[key]) do
            self.key_pressed[k] = false
            self.key_released[k] = false
            self.key_down[k] = false
        end
        return false
    else
        self.key_pressed[key] = false
        self.key_released[key] = false
        self.key_down[key] = false
    end
end

function Input.lock(target)
    table.insert(self.lock_stack, target)
end

function Input.release(target)
    if not target then
        table.remove(self.lock_stack, #self.lock_stack)
    else
        Utils.removeFromTable(self.lock_stack, target)
    end
end

function Input.check(target)
    return self.lock_stack[#self.lock_stack] == target
end

function Input.onKeyPressed(key)
    self.key_down[key] = true
    self.key_pressed[key] = true
end

function Input.onKeyReleased(key)
    self.key_down[key] = false
    self.key_released[key] = true
end

function Input.down(key)
    if self.aliases[key] then
        for _,k in ipairs(self.aliases[key]) do
            if self.key_down[k] then
                return true
            end
        end
        return false
    else
        return self.key_down[key]
    end
end

function Input.keyDown(key)
    return self.key_down[key]
end

function Input.pressed(key)
    if self.aliases[key] then
        for _,k in ipairs(self.aliases[key]) do
            if self.key_pressed[k] then
                return true
            end
        end
        return false
    else
        return self.key_pressed[key]
    end
end

function Input.consumePress(key)
    if self.aliases[key] then
        local pressed = false
        for _,k in ipairs(self.aliases[key]) do
            if self.key_pressed[k] then
                self.key_pressed[k] = nil
                pressed = true
            end
        end
        return pressed
    else
        local pressed = self.key_pressed[key]
        self.key_pressed[key] = nil
        return pressed or false
    end
end

function Input.keyPressed(key)
    return self.key_pressed[key]
end

function Input.released(key)
    if self.aliases[key] then
        for _,k in ipairs(self.aliases[key]) do
            if self.key_released[k] then
                return true
            end
        end
        return false
    else
        return self.key_released[key]
    end
end

function Input.keyReleased(key)
    return self.key_released[key]
end

function Input.up(key)
    if self.aliases[key] then
        for _,k in ipairs(self.aliases[key]) do
            if self.key_down[k] then
                return false
            end
        end
        return true
    else
        return not self.key_down[key]
    end
end

function Input.keyUp(key)
    return not self.key_down[key]
end

function Input.is(alias, key)
    return self.aliases[alias] and Utils.containsValue(self.aliases[alias], key)
end

function Input.getText(alias)
    local name = self.aliases[alias] and self.aliases[alias][1] or alias
    return "["..name:upper().."]"
end

function Input.isConfirm(key)
    return Utils.containsValue(self.aliases["confirm"], key)
end

function Input.isCancel(key)
    return Utils.containsValue(self.aliases["cancel"], key)
end

function Input.isMenu(key)
    return Utils.containsValue(self.aliases["menu"], key)
end

function Input.getMousePosition()
    return love.mouse.getX() / (Kristal.Config["windowScale"] or 1), love.mouse.getY() / (Kristal.Config["windowScale"] or 1)
end

return Input