player = {}
playerList = {}

function player:new(x, y, controls)
  o = {}
  setmetatable(o, {__index = self})
  
  o.x, o.y, o.controls = x, y, controls
  o.width = 32
  o.height = 64
  o.isGrounded = false
  o.yVel = 0
  
  --balancing variables
  o.horizSpeed = 100
  o.gravity = 50
  o.jumpSpeed = -200
  
  table.insert(playerList, o)
end

function player:checkCollision(block) --P.O.S. collisions fucking shit (Physics Engine if you're a fucking idiot like Jonh)
  local dx = self.x - block.x
  local dy = self.y - block.y
  
  local xOverlap = (self.width/2 + block.width/2) - math.abs(self.x - block.x)
  local yOverlap = (self.height/2 + block.height/2) - math.abs(self.y - block.y)
  
  local direction = ""
  
  if xOverlap > 0 and yOverlap > 0 then
    if math.abs(dx) > math.abs(dy) then
      if dx > 0 then -- all of these strings refrence where the player is relative to the block; fuck your shitty comments Jonh, rot in hell
        direction = "right"
      else
        direction = "left"
      end
    else
      if dy > 0 then
        direction = "below"
      else
        direction = "above"
      end
    end
  end
  
  return direction, dx, dy, xOverlap, yOverlap
end

function player:update(dt)
  --[[if self.isGrounded then
    if love.keyboard.isDown(self.controls.up) then
      yVel = self.jumpSpeed
      self.isGrounded = false
    end
  else
    for i, v in ipairs(blockList) do
      local dir, dx, dy, xOver, yOver = self:checkCollision(v)
      if dir then
        if dir == "above" then
          self.yVel = 0
          self.y = self.y - yOver
          self.isGrounded = true
        elseif dir == "below" then
          self.yVel = 0
          self.y = self.y + yOver
        end
      end
    end
  end]]
  
  if not self.isGrounded then --updates the fucking y position and goddamn y velocity you whore dammit
    self.yVel = self.yVel + (self.gravity * dt)
    self.y = self.y + self.yVel
  end
  
  if love.keyboard.isDown(self.controls.left) then --shitty x position update shit
    x = x - self.horizSpeed * dt
  elseif love.keyboard.isDown(self.controls.right) then
    x = x + self.horizSpeed * dt
  end
end

function player:draw()
  love.graphics.rectangle("fill", self.x - self.width/2, self.y - self.height/2, self.width, self.height)
end