player = {}
playerList = {}

function player:new(x, y, controls)
  o = {}
  setmetatable(o, {__index = self})

  o.position = vector:new(x, y)
  o.controls = controls
  o.width = 32
  o.height = 64
  o.isGrounded = false
  o.velocity = vector:new(0, 0)

  self.dir, self.dx, self.dy, self.xOver, self.yOver = nil, nil, nil, nil, nil --colision vars

  --balancing variables
  o.horizSpeed = 100
  o.gravity = 50
  o.jumpSpeed = -200

  table.insert(playerList, o)
end

function player:checkCollision(block) --P.O.S. collisions fucking shit (Physics Engine if you're a fucking idiot like Jonh)
  local dx = self.position.x - block.position.x
  local dy = self.position.y - block.position.y

  local xOverlap = (self.width/2 + block.width/2) - math.abs(self.position.x - block.position.x)
  local yOverlap = (self.height/2 + block.height/2) - math.abs(self.position.y - block.position.y)

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

  return direction, dx, dy, xOverlap, yOverlap --dx and dy reference the the difference in position coordinates, xOverlap and yOverlap take into acount width an height of the two objects
end

function player:updateCollision(dt)
  for i, v in ipairs(blockList) do
    self.dir, self.dx, self.dy, self.xOver, self.yOver = self:checkCollision(v)
  end

  if dir then --if a collision fucking occured, adjust shitty x & y
    if dir == "above" then
      self.position.y = self.position.y - yOver
    elseif dir == "below" then
      self.position.y = self.position.y + yOver
    elseif dir == "right" then
      self.position.x = self.position.x + xOver
    elseif dir == "left" then
      self.position.x = self.position.x - xOver
    end
  end
end

function player:updateState(dt)
  if self.isGrounded then
    if love.keyboard.isDown(self.controls.up) then --jumping logic & shite
      self.velocity = vector:new(0, jumpSpeed)
      self.isGrounded = false
    end
  else
    if self.dir then --land if you hit a block from above, dumbass
      if self.dir == "above" then
        self.yVel = new:vector(0, 0)
        self.isGrounded = true
      end
    end
  end
end

function player:updateVelocity(dt)
  if not self.isGrounded then
    self.velocity = self.velocity:add(vector:new(0, self.gravity * dt)) -- update velocity for gravity
  end

  if love.keyboard.isDown(self.controls.left) then --shitty x velocity update for keypresses
    self.velocity = velocity:add(vector:new(-self.horizSpeed, 0))
  elseif love.keyboard.isDown(self.controls.right) then
    self.velocity = velocity:add(vector:new(self.horizSpeed, 0))
  end

end

function player:update(dt)
  self:updateCollision(dt)
  self:updateState(dt)
  self:updateVelocity(dt)

  --self.position = self.position:add
end

function player:draw()
  love.graphics.rectangle("fill", self.x - self.width/2, self.y - self.height/2, self.width, self.height)
end
