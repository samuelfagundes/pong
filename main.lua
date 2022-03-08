push = require 'libraries/push'
Class = require 'libraries/class'

require 'Classes/Paddle'

require 'Classes/Ball'

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

    -- Create a random seed based on time passed, will always be different
    math.randomseed(os.time())

    -- Add the fonts
    smallFont = love.graphics.newFont('/fonts/font.ttf', 8)
    scoreFont = love.graphics.newFont('/fonts/font.ttf', 32)

    -- Set screen size and configuration
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- Define players score
    player1Score = 0
    player2Score = 0

   player1 = Paddle(10, 30, 5, 20)
   player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

   ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    gameState = 'start'
end

function love.update(dt)
    -- Allows the movement of the player 1 paddles
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end
    
    -- Allows the movement of the player 2 paddles
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
    -- Close the program using 'esc'
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gamestate = 'start'

            ball:reset()
        end
    end
end

function love.draw()
    -- Init the library 'push'
    push:apply('start')

    -- Set the background color
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    -- Set the font size and print the text 'Hello Pong!' on the screen
    love.graphics.setFont(smallFont)
    
    if gameState == 'start' then
    love.graphics.printf(
        'Press ENTER to play!',
        0,
        20,
        VIRTUAL_WIDTH,
        'center'
    )
    end

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

    -- Render player 1 paddle
    player1:render()
    -- Render player 2 paddle
    player2:render()
    -- Render ball (center)
    ball:render()

    push:apply('end')
end