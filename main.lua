flux = require "lib/flux"

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

    timer = 180
    score = 0

    love.mouse.setVisible(false)

    -- testing position 1 duck
    duck = {
        x = 0,
        y = 0,
        sprite = sprites.duck1
    }

    flux.to(duck, 2, {x =200, y = 120}):ease("quartin"):delay(0.5)

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

    flux.update(dt)
end

function love.draw()

    -- draw bg with 0.8 scale
    love.graphics.push()
    love.graphics.scale(0.8, 0.8)
    love.graphics.draw(sprites.bg, 0, 0)
    love.graphics.pop()

    -- draw duck / target
    love.graphics.draw(duck.sprite, duck.x, duck.y)
    -- love.graphics.draw(sprites.target, 100, 100)

    -- draw normal size all
    local x, y = love.mouse.getPosition()
    local string_timer = caltulate_timer(timer)
    love.graphics.print(string_timer, 10, 10)
    love.graphics.print("Score: "..score, 360, 30)
    love.graphics.draw(sprites.crosshair, x-36, y-36)
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        print("Left mouse button pressed")
    elseif button == 2 then
        print("Right mouse button pressed")
    end
end

function caltulate_timer(time)
    local minutes = math.floor(time / 60)
    local seconds = math.floor(time % 60)

    if(seconds < 10) then
        seconds = "0"..seconds
    end

    return minutes..":"..seconds
end