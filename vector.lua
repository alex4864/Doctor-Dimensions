vector = {}

<<<<<<< HEAD
function vector:new(x, y)
=======
function vector:new(x, y) -- Creates a new fucking badass lookin vector for your shitty ass
>>>>>>> master
  local o = {}
  setmetatable(o, {__index = self})

  o.x, o.y = x, y

  return o
end

function vector:truncate(maxValue) -- Checks the current scalar length, and if the length is more than maxValue. If it is, truncates down to maxValue. (By the way, fuck you)
  if self:getScalar() > maxValue then
    return self:multiply(maxValue / self:getScalar())
  else
    return self
  end
end

function vector:scale(maxValue) -- like truncate, but can increase or decrease to fuckin maxValue
  return self:multiply(maxValue / self:getScalar())
end

function vector:add(inputVector) -- What do you think it does shithead? It adds the vectors
  local x = self.x + inputVector.x
  local y = self.y + inputVector.y
  return vector:create(x, y)
end

function vector:subtract(inputVector) -- Seriously, you're wondering what this does ALSO? IS IT NOT FUCKING APPARENT?!?! THIS FUCKING SUBTRACTS VECTORS
  local x = self.x - inputVector.x
  local y = self.y - inputVector.y
  return vector:create(x, y)
end

function vector:multiply(scalar) -- Holy shit how did you graduate KINDERGARTEN if you STILL DON'T KNOW WHAT THESE DO! IT MULTIPLIES THE CURRENT VECTOR
  local x = self.x * scalar
  local y = self.y * scalar
  return vector:create(x, y)
end

function vector:rotate(angle) -- Rotates it by the angle specified, shithead
  local x = math.cos(rotateAngle) * self.x - math.sin(rotateAngle) * self.y
  local y = math.sin(rotateAngle) * self.x + math.cos(rotateAngle) * self.y
  return vector:create(x, y)
end

function vector:getScalar() -- PYTHAGOREAN THEOREM BIATCH
  return math.sqrt(math.pow(self.x, 2) + math.pow(self.y, 2))
end

function vector:getAngle() -- Gettin a fuckin tan while gettin the angle to the horizon (get it?) fuck you Alex
  if self:getScalar() > 0 then
    return math.atan2(self.y, self.x)
  else
    return 0
  end
end

function sumVectorTable(vectorTable) -- If you have a table of vectors, it adds them. DUH
  output = vector:create(0, 0)

  for i, v in ipairs(vectorTable) do
    output = output:add(v)
  end

  return output
end
