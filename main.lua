flux = require "lib/flux"
sfxr = require "lib/sfxr"

function love.load()
    sprites = {}

    sprites.crosshair = love.graphics.newImage("assets/img/crosshair.png")
    sprites.bg = love.graphics.newImage("assets/img/colored_forest.png")
    sprites.cloud1 = love.graphics.newImage("assets/img/cloud1.png")
    sprites.cloud2 = love.graphics.newImage("assets/img/cloud2.png")
    sprites.cloud3 = love.graphics.newImage("assets/img/cloud3.png")
    sprites.cloud4 = love.graphics.newImage("assets/img/cloud4.png")
    sprites.cloud5 = love.graphics.newImage("assets/img/cloud5.png")
    sprites.cloud6 = love.graphics.newImage("assets/img/cloud6.png")
    sprites.cloud7 = love.graphics.newImage("assets/img/cloud7.png")
    sprites.cloud8 = love.graphics.newImage("assets/img/cloud8.png")
    sprites.cloud9 = love.graphics.newImage("assets/img/cloud9.png")

    sprites.duck1 = love.graphics.newImage("assets/img/duck1.png")
    sprites.duck2 = love.graphics.newImage("assets/img/duck2.png")
    sprites.duck3 = love.graphics.newImage("assets/img/duck3.png")
    sprites.target = love.graphics.newImage("assets/img/target_outline.png")

    game_font = love.graphics.newFont(30)

    -- set font
    love.graphics.setFont(game_font)

    timer = 180
    time_spawn = 1
    score = 0

    love.mouse.setVisible(false)

    -- testing position 1 duck
    duck = {
        x = 0,
        y = 0,
        sprite = sprites.duck1,
        size = {
            radius = 45,
            offset = 30
        },
        killed = false
    }

    ducks = {}

    -- testing tween
    flux.to(duck, 2, {x =200, y = 120}):ease("quartin"):delay(0.5):oncomplete(duck_complete_tween)

end

function love.update(dt)
    -- input_pos.x = love.mouse.getX()
    -- input_pos.y = love.mouse.getY()
    timer = timer - dt
    if(timer < 0) then
        timer = 0
        -- love.event.quit("restart")
        love.event.quit()
    end

    time_spawn = time_spawn - dt
    if(time_spawn < 0) then
        time_spawn = 1
        spawn_duck()
    end

    flux.update(dt)
end

function love.draw()

    -- draw bg with 0.8 scale
    love.graphics.push()
    love.graphics.scale(0.8, 0.8)
    love.graphics.draw(sprites.bg, 0, 0)
    love.graphics.pop()


    for i, d in ipairs(ducks) do
        if (not d.killed) then
            love.graphics.draw(d.sprite, d.x, d.y)
            love.graphics.circle("line", d.x + d.size.offset+  d.size.radius*.5, d.y+d.size.offset+d.size.radius*.5, d.size.radius)
        end
    end
    
    -- draw duck / target
    if (not duck.killed) then
        love.graphics.draw(duck.sprite, duck.x, duck.y)
        love.graphics.circle("line", duck.x + duck.size.offset+  duck.size.radius*.5, duck.y+duck.size.offset+duck.size.radius*.5, duck.size.radius)
    end
    -- love.graphics.draw(sprites.target, 100, 100)

    -- draw normal size all
    local x, y = love.mouse.getPosition()
    local string_timer = caltulate_timer(timer)

    -- tinting color to black
    love.graphics.setColor(0,0,0)
    love.graphics.print(string_timer, 10, 10)
    love.graphics.print("Score: "..score, 360, 30)

    -- tinting color to white (back to normal)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(sprites.crosshair, x-36, y-36)
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        print("Left mouse button pressed")
        if math.sqrt((x - (duck.x + duck.size.offset + duck.size.radius*.5))^2 + (y - (duck.y + duck.size.offset + duck.size.radius*.5))^2) < duck.size.radius and not duck.killed then
            score = score + 1
            duck.killed = true
            -- duck.x = 0
            -- duck.y = 0
            -- duck.sprite = sprites.duck1
            -- flux.to(duck, 2, {x =200, y = 120}):ease("quartin"):delay(0.5)
        end
    elseif button == 2 then
        print("Right mouse button pressed")
    end
end

-- testing sound play using sfxr
function love.keypressed(key, rep)
    if key == "space" then
        love.event.quit("restart")
    end
    -- local sound = sfxr.newSound()
    -- sound:randomize()
    -- local sounddata = sound:generateSoundData()
    -- local source = love.audio.newSource(sounddata)
    -- source:play()
end

function spawn_duck()
    local one_duck = {
        x = math.random(20, love.graphics.getWidth()-20),
        y = math.random(20, love.graphics.getHeight()-20),
        sprite = sprites.duck1,
        size = {
            radius = 45,
            offset = 30
        },
        killed = false
    }

    table.insert(ducks, one_duck)
end

function duck_complete_tween()
    -- duck.x = 0
    -- duck.y = 0
    -- duck.sprite = sprites.duck1
    -- duck.killed = false
    local rand={
        x = math.random(0, 800),
        y = math.random(0, 600),
    }
    flux.to(duck, 2, {x =rand.x, y = rand.y}):ease("quartin"):delay(0.5):oncomplete(duck_complete_tween)
end

function caltulate_timer(time)
    local minutes = math.floor(time / 60)
    local seconds = math.floor(time % 60)

    if(seconds < 10) then
        seconds = "0"..seconds
    end

    return minutes..":"..seconds
end