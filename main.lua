require "vector"
require "player"
require "block"

function love.load()
  player:new(100, 100, {left = "a", right = "d", up = "w", down = "s"})
end

function love.update(dt)
  playerList[1]:update(dt)
end

function love.draw()
  playerList[1]:draw()
end
