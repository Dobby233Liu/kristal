return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    wall = function(cutscene, event)
        -- Open textbox and wait for completion
        cutscene:text("* The wall seems cracked.")

        -- If we have Susie, play a cutscene
        local susie = cutscene:getCharacter("susie")
        if susie then
            -- Detach camera and followers (since characters will be moved)
            cutscene:detachCamera()
            cutscene:detachFollowers()

            -- All text from now is spoken by Susie
            cutscene:setSpeaker(susie)
            cutscene:text("* Hey,[wait:5] think I can break\nthis wall?", "smile")

            -- Get the bottom-center of the broken wall
            local x = event.x + event.width/2
            local y = event.y + event.height/2

            -- Move Susie up to the wall over 0.75 seconds
            cutscene:walkTo(susie, x, y + 40, 0.75, "up")
            -- Move other party members behind Susie
            cutscene:walkTo(Game.world.player, x, y + 100, 0.75, "up")
            if cutscene:getCharacter("ralsei") then
                cutscene:walkTo("ralsei", x + 60, y + 100, 0.75, "up")
            end
            if cutscene:getCharacter("noelle") then
                cutscene:walkTo("noelle", x - 60, y + 100, 0.75, "up")
            end

            -- Wait 1.5 seconds
            cutscene:wait(1.5)

            -- Walk back,
            cutscene:wait(cutscene:walkTo(susie, x, y + 60, 0.5, "up", true))
            -- and run forward!
            cutscene:wait(cutscene:walkTo(susie, x, y + 20, 0.2))

            -- Slam!!
            Assets.playSound("impact")
            susie:shake(4)
            susie:setSprite("shock_up")

            -- Slide back a bit
            cutscene:slideTo(susie, x, y + 40, 0.1)
            cutscene:wait(1.5)

            -- owie
            susie:setAnimation({"away_scratch", 0.25, true})
            susie:shake(4)
            Assets.playSound("wing")

            cutscene:wait(1)
            cutscene:text("* Guess not.", "nervous")

            -- Reset Susie's sprite
            susie:resetSprite()

            -- Reattach the camera
            cutscene:attachCamera()

            -- Align the follower positions behind Kris's current position
            cutscene:alignFollowers()
            -- And reattach them, making them return to their target positions
            cutscene:attachFollowers()
            Game:setFlag("wall_hit", true)
        end
    end,
	
    nokia_dog = function(cutscene, event)
        local dog = cutscene:getCharacter("dog")

        cutscene:showNametag("Dog")
        cutscene:text("* I'm just a dog, but I'm also...")
        cutscene:hideNametag()

        Game.world.music:pause()
        local nokia = Music("nokia")
        nokia:play()
        cutscene:wait(2.5)

        cutscene:showNametag("Dog")
        dog:setAnimation("holdphone")
        cutscene:text("* Who the...")
		cutscene:text("* Excuse me for a sec.")
		nokia:remove()
		dog:setAnimation("talkphone")
		cutscene:text("* .[wait:5].[wait:5].[wait:10]Hello?")
        cutscene:hideNametag()

        local dmc2 = Music("voiceover/plaeDMC2")
        dmc2:play()
        cutscene:wait(2.5)

        cutscene:showNametag("Dog")
        cutscene:text("* ...[wait:10]You again.")
        cutscene:text("* I already told you...[wait:5]\nTHIS ISN'T FUNNY!")
        dog:setAnimation("holdphone")
        cutscene:text("* Hey...[wait:5] Hey![wait:5] HEEEY![wait:5] \nARE YOU LISTENING TO ME?")
        cutscene:text("* I've had enough of this!")
        cutscene:text("* I have your number you know,[wait:5]\nI know where you live.[wait:8]\n* YOU...[wait:10][shake:2]SCUM!!!")
        cutscene:hideNametag()

		dmc2:remove()
		Game.world.music:resume()
		dog:resetSprite()
    end,

    malius = function(cutscene, event)
        Game.world:openMenu(FuseMenu())
    end,

    fun_fax = function(cutscene, event)
        Assets.playSound("bell")
        cutscene:wait(0.25)
        Assets.playSound("bell")
        cutscene:wait(1)

        local fun_fax = Game.world:spawnNPC("fun_fax", -210, 660)

        Game.world.music:fade(0, 0.25)

        Assets.playSound("mac_start")
        cutscene:slideTo(fun_fax, 310, 660, 0.8, "in-out-quint")

        if not Game:getFlag("met_fun_fax") then
            Game:setFlag("met_fun_fax", true)

            cutscene:wait(5)

            cutscene:text("* [speed:0.2]Mmmmm,[wait:20][speed:0.2]\nyes[speed:0.1]..........")

            fun_fax:setSprite("watching")
            cutscene:wait(3)
            fun_fax:setSprite("searching")
            cutscene:wait(2)
            fun_fax:setSprite("watching")
            cutscene:wait(1)
            fun_fax:setSprite("searching")
            cutscene:wait(0.5)
            fun_fax:setSprite("watching")
            cutscene:wait(0.5)
            fun_fax:setSprite("searching")
            cutscene:wait(0.5)
            fun_fax:setSprite("watching")
            cutscene:wait(0.5)
            fun_fax:setSprite("searching")
            cutscene:wait(0.25)
            fun_fax:setSprite("searching")
            cutscene:wait(0.12)
            fun_fax:setSprite("watching")
            cutscene:wait(0.05)
            fun_fax:setSprite("searching")
            cutscene:wait(0.05)
            fun_fax:setSprite("watching")
            cutscene:wait(0.05)
            fun_fax:setSprite("searching")
            cutscene:wait(0.05)
            fun_fax:setSprite("watching")
            cutscene:wait(0.05)
            fun_fax:setSprite("searching")
            cutscene:wait(0.005)
            fun_fax:setSprite("watching")
            cutscene:wait(0.0005)
            fun_fax:setSprite("searching")
            cutscene:wait(0.00005)
            fun_fax:setSprite("watching")
            cutscene:wait(0.000005)
            fun_fax:setSprite("searching")
            cutscene:wait(0.0000005)
            for _ = 1, 8 do
                fun_fax:setSprite("watching")
                cutscene:wait(0.0000005)
                fun_fax:setSprite("searching")
                cutscene:wait(0.0000005)
            end
            fun_fax:setSprite("searching")
            cutscene:wait(3)
            fun_fax:setSprite("watching")
            cutscene:wait(5)

            cutscene:text("* Alola...")
            cutscene:text("* [speed:0.5]That's a pokemon yaknow...[wait:25]\n...[wait:25]\n...")
            cutscene:text("* [speed:0.25]...[wait:25]\n...[wait:25]\n...")
            cutscene:text("* [speed:0.25]...[wait:25]\n...[wait:25]\n...")

            cutscene:wait(3)
        else
            cutscene:wait(4)
            fun_fax:setSprite("watching")
            cutscene:wait(1)
            fun_fax:setSprite("searching")
            cutscene:wait(0.5)
            fun_fax:setSprite("watching")
            cutscene:wait(0.25)
        end

        fun_fax:setSprite("searching")
        cutscene:wait(0.5)
        Assets.playSound("ui_select")
        cutscene:wait(0.1)

        local music_assets = Assets.data.music

        local track_names = {}

        for track_name, _ in pairs(music_assets) do
            table.insert(track_names, track_name)
        end

        local random_theme = Music(Utils.pick(track_names), 0.8, 1)

        cutscene:wait(0.4)
        fun_fax:setSprite("watching")
        cutscene:wait(2)

        local dialogue_pairs = {
            {"* I wrote a book recently...", "* It had a few quotes..."},
            {"* Mama always said life was like a box-o-chocolates...", "* Ya never know what ya might get..."},
            {"* Have you heard of the woody theory...", "* It means there is a friend inside you..."},
            {"* AcousticJamm once said...", "* Brb, I gotta iron my fish..."},
            {"* Did you know sans is Ness...", "* Game Theory told me so..."},
            {"* Did you know Dess is Ness...", "* JaruJaruJ told me so..."},
            {"* I can see your FUN value...", "* I'm not allowed to tell you though..."},
            {"* Don't forget...", "* I'm with you in the dark..."},
            {"* You need to go fast...", "* As fast as you can..."},
            {"* A room in between...", "* It may go on forever..."},
            {"* The DEVS don't know they aren't the real ones...", "* Never tell them this information..."},
            {"* DeltaDreams died for this...", "* Not really..."},
            {"* I can see things far away...", "* I can't see you..."},
            {"* Drink soda...", "* It'll help you see faster..."},
            {"* I had a wife...", "* But they took her in the devorce..."},
            {"* I was created in a night...", "* Sleep deprivation is unhealthy..."},
            {"* This is a full quote in the code...", "* It was just split into two..."},
            {"* If it's not worth it...", "* You should not do it..."},
            {"* Hunger strikes me...", "* I must proceed..."},
            {"* The lore doesn't matter...", "* Just enjoy the fun..."},
            {"* There is nobody behind the tree...", "* I checked..."},
            {"* Time does not matter...", "* It always ends..."},
            {"* Do your choices matter...", "* It always depends..."},
            {"* What is a dark world...", "* A world in darkness..."},
            {"* Is there a light fountain...", "* I would not know..."},
            {"* Do you miss them...", "* You probably don't know who I'm talking about..."},
            {"* Is it fate...", "* Or is it chance..."},
            {"* Gender is odd to me...", "* It keeps being updated..."},
            {"* The end is never...", "* Or so I was told..."},
            {"* The line between fact and fiction can be blurred...", "* Until it isn't there anymore..."},
            {"* Our universe doesn't have a lightner strong enough to seal our fountain...", "* So we looked in other worlds..."},
            {"* Our world grows unstable...", "* A single BAD HOOK could end it all..."},
            {"* A giant schoolgirl and a boot are lurking...", "* They both seem famillar somehow..."},
            {"* What counts as a duplicate...", "* And what does not..."},
            {"* There is only one being more aware then the self aware characters here...", "* How does it feel to be that being?\n* Don't answer,[speed:0.25]I can't hear you."},
            {"* If my thoughts were still in order...", "* I would be able to socialize agian..."},
            {"* The timelines...", "* They're three of them..."},
            {"* A DEV tried to fix me...", "* But I was never broken..."}, --But holy hell did you optimize my fucking shitty code
            {"* I've heard a story once...", "* I forgot how it ends..."},
            {"* The shop out of bounds...", "* The guy inside it is an handful..."},
            {"* People often ask what's my head...", "* I'm getting too old for this..."},
            {"* Simbel once said...", "* I don't have his quote yet..."},
            {"* I tried to talk to people once...", "* But they all just said \"Why are you in my house?\"..."},
            {"* Here's a fact about Kristal...", "* It's a combination of \"Crystal\" and \"Kris\"..."},
            {"* You can recruit your enemies now...", "* But where do they go after the battle..."},
            {"* Keep your friends close to you...", "* And your enemies even closer..."},
            {"* What's canon...", "* Well it's a weapon..."},
            {"* Don't forget to take a break...", "* Lack of sleep is bad, y'know..."},
            {"* It's raining somewhere else...", "* So take out your umbrella..."},
            {"* [color:grey]GREY[color:reset]...", "* [color:grey]AREA[color:reset]..."},
            {"* We are reborn...", "* Despite never being born..."},
            {"* Have you seen my friend...", "* His name is [color:yellow]Wocter Ding Dings[color:reset]..."},
            {"* Don't mess with reality...", "* This is a [color:red]threat[color:reset]..."}
        }

        cutscene:text("[speed:0.5]" .. Utils.pick(dialogue_pairs)[1])

        fun_fax:setSprite("searching")
        cutscene:wait(1.5)
        fun_fax:setSprite("watching")
        cutscene:wait(1.5)

        cutscene:text("[speed:0.5]" .. Utils.pick(dialogue_pairs)[2])

        cutscene:wait(3)
        fun_fax:setSprite("searching")
        Assets.playSound("ui_select")
        random_theme:stop()
        cutscene:wait(0.2)
        fun_fax:setSprite("watching")
        cutscene:wait(2)

        cutscene:slideTo(fun_fax, 800, 660, 0.8, "in-out-quint")
        Assets.playSound("mac_start")
        cutscene:wait(0.2)
        fun_fax:setSprite("searching")
        cutscene:wait(2)

        fun_fax:remove()
        Game.world.music:fade(1, 0.5)
    end,

    sans = function(cutscene, event)
        if cutscene:getCharacter("susie") then
            if event.interact_count == 1 then
                cutscene:showNametag("Susie")
                cutscene:text("* You??", "teeth_b", "susie")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* hey.", "neutral", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* What are you DOING here??", "teeth", "susie")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* i'm keeping people away from this elevator.", "look_left", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* You...[wait:3] don't seem to be doing that right now.", "suspicious", "susie")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* yeah it's because it's finished now.", "neutral", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* ...[wait:3]Then why are you still keeping people away from it??", "sus_nervous", "susie")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* contract obligations.", "joking", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* Right...", "sus_nervous", "susie")
                cutscene:hideNametag()
            else
                cutscene:showNametag("Susie")
                cutscene:text("* How are you here by the way?", "neutral", "susie")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* i don't know. i'm just here for the work.", "neutral", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* Do you even know something?", "annoyed", "susie")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* hey, if you have a complaint[wait:1] you can tell my manager.", "joking", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* And who would that be?", "neutral_side", "susie")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* me.", "neutral", "sans")

                cutscene:showNametag("Susie")
                cutscene:text("* Aren't you already the cashier at Hometown??", "angry", "susie")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* nah, i'm the janitor.", "wink", "sans")
                cutscene:hideNametag()
            end
        elseif cutscene:getCharacter("noelle") then
            if event.interact_count == 1 then
                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* hey.", "neutral", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* Uhm...[wait:4] Hello?", "smile_closed", "noelle")
                cutscene:text("* Wait, aren't you the guy keeping the store in Hometown?", "smile", "noelle")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* nah, i'm just the cashier.", "neutral", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* Oh? But isn't the store named after you?", "question", "noelle")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* nah, that's the name of the owner.", "look_left", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* Oh! Sorry for the confusion![wait:3] Can I ask for your name then?", "smile_closed", "noelle")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* wow there girl, you don't just ask a hard worker like me his name. it's weird.", "joking", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* O-Oh... Sorry.", "surprise_frown_b", "noelle")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* it's okay.[wait:3] i don't get pay enough to get mad at people.", "wink", "sans")
                cutscene:hideNametag()
            else
                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* what's up?", "neutral", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* Nothing special, mister... Uh..", "smile_closed", "noelle")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* sans.[wait:2] sans the skeleton.", "wink", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* Oh okay, mister...[wait:4] [face:confused_surprise]Sans..?[wait:4][face:confused_surprise_b] Skeleton??[wait:4][face:question] The Skeleton???", "smile", "noelle")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* how about you just call me sans?[wait:3] sounds nicer, right?", "look_left", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* I guess so, yeah..", "smile_side", "noelle")
                cutscene:text("* Wait... So your name IS Sans!", "surprise_smile_b", "noelle")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* that's me.", "neutral", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* I thought I shouldn't ask an hard worker his name!", "smile_closed", "noelle")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* wow, the guy who told you that must be really weird.", "joking", "sans")
                cutscene:text("[font:sans]* there's nothing wrong with knowing someone's name, you know?", "wink", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* ...", "what", "noelle")
                cutscene:text("* Then uh.. Aren't you the owner of the shop in Hometown?", "question", "noelle")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* nah, i'm their janitor.", "neutral", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* But didn't you tell us you were their cashier?", "frown", "noelle")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* i'm just filling in.[wait:3] employees are hard to find nowadays.", "look_left", "sans")

                cutscene:showNametag("Noelle")
                cutscene:text("* Did you try to start some employment campaign?", "smile_closed_b", "noelle")

                cutscene:showNametag("Sans", {font = "sans"})
                cutscene:text("[font:sans]* can't do that on a janitor's salary unfortunately.", "eyes_closed", "sans")
                cutscene:hideNametag()
            end
        else
            local kid = #Game.party > 1 and "kids" or "kid"
            cutscene:showNametag("Sans", {font = "sans"})
            cutscene:text(string.format("[font:sans]* hey %s.[wait:5] sorry but you can't access the elevator yet.", kid), "neutral", "sans")
            cutscene:text("[font:sans]* it's kinda...[wait:5] not finished.", "look_left", "sans")
            cutscene:text("[font:sans]* so come back later,[wait:2] 'k?", "wink", "sans")
            cutscene:hideNametag()
        end
    end,
}
