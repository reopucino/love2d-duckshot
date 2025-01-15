function love.load()
    sprites = {}

    sprites.crosshair = love.graphics.newImage("assets/img/crosshair.png")

    timer = 180
    score = 0

    love.mouse.setVisible(false)
end

function love.update(dt)
    -- input_pos.x = love.mouse.getX()
    -- input_pos.y = love.mouse.getY()
    timer = timer - dt
    if(timer < 0) then
        timer = 0
        love.event.quit("restart")
    end
end

function love.draw()
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
    return minutes..":"..seconds
end