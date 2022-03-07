local push = require 'libraries/push'

-- Variable to set window size
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Variable to ajust window size
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Variable to set paddle speed
PADDLE_SPEED = 200

function love.load()
    -- Filter to take out the blur filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Add the fonts
    smallFont = love.graphics.newFont('/fonts/font.ttf', 8)
    scoreFont = love.graphics.newFont('/fonts/font.ttf', 32)

    -- Set screen size and configuration
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = false
    })

    -- Define players score
    player1Score = 0
    player2Score = 0

    -- Paddle initial Y position
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end

function love.update(dt)
    -- Allows the movement of the paddles
    if love.keyboard.isDown('w') then
        player1Y = player1Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    if love.keyboard.isDown('up') then
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
end

function love.keypressed(key)
    -- Close the program using 'esc'
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    -- Init the library 'push'
    push:apply('start')

    -- Set the background color
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    -- Set the font size and print the text 'Hello Pong!' on the screen
    love.graphics.setFont(smallFont)
    love.graphics.printf(
        'Hello Pong!',
        0,
        20,
        VIRTUAL_WIDTH,
        'center'
    )

    -- Change font and show the score
    love.graphics.setFont(scoreFont)
    love.graphics.print(
        tostring(player1Score),
        VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(
        tostring(player1Score),
        VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)

    -- Player 1 paddle
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    -- Player 2 paddle
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    -- Ball
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    push:apply('end')
end