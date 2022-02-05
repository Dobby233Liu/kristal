return {
    susie_punch = function(cutscene, battler, enemy)
        -- Hurt the target enemy for 1 damage
        Assets.playSound("snd_damage")
        enemy:hurt(1, battler)

        -- Open textbox and wait for completion
        cutscene:text("* Susie threw a punch at\nthe dummy.")

        if not enemy.punched then
            -- Set custom variable
            enemy.punched = true

            -- Susie text
            cutscene:text("* You,[wait:5] uh,[wait:5] look like a weenie.[wait:5]\n* I don't like beating up\npeople like that.", "face_20", "susie")

            if cutscene:getCharacter("ralsei") then
                -- Ralsei text, if he's in the party
                cutscene:text("* Aww, Susie!", "face_17", "ralsei")
            end
        end
    end
}