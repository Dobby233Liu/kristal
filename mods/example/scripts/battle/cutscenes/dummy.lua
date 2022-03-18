return {
    susie_punch = function(cutscene, battler, enemy)
        -- Hurt the target enemy for 1 damage
        Assets.playSound("snd_damage")
        enemy:hurt(1, battler)
        if not enemy.punched then
            -- Set custom variable
            enemy.punched = true

            -- Susie text
            cutscene:text("* You,[wait:5] uh,[wait:5] look like a weenie.[wait:5]\n* I don't like beating up\npeople like that.", "nervous_side", "susie")

            if cutscene:getCharacter("ralsei") then
                -- Ralsei text, if he's in the party
                cutscene:text("* Aww,[wait:5] Susie!", "blush_pleased", "ralsei")
            end
        end
    end
}