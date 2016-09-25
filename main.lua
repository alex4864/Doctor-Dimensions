require "vector"
require "player"
require "block"

function love.load()
  block:new(20,20)
end

function love.update(dt)

end

function love.draw()
  blockList[1]:draw()
end
