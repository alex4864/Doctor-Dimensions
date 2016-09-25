block = {}
blockList = {}

function block:new(x, y)
  o = {}
  setmetatable(o, {__index = self})
  
  o.position = vector:new(x, y)
  o.width = 32
  o.height = 32
  
  table.insert(blockList, o)
end

function block:draw()
  love.graphics.rectangle("line", self.position.x - self.width/2, self.position.y - self.height/2, self.width, self.height)
end