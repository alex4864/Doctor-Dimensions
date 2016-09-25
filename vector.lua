vector = {}

function vector:create(x, y)
  local o = {}
  setmetatable(o, {__index = self})
  
  o.x, o.y = x, y
  
  return o
end

function vector:truncate(maxValue)
  if self:getScalar() > maxValue then
    return self:multiply(maxValue / self:getScalar())
  else
    return self
  end
end

function vector:scale(maxValue) -- like truncate, but can increase or decrease to maxValue
  return self:multiply(maxValue / self:getScalar())
end

function vector:add(inputVector)
  local x = self.x + inputVector.x
  local y = self.y + inputVector.y
  return vector:create(x, y)
end

function vector:subtract(inputVector)
  local x = self.x - inputVector.x
  local y = self.y - inputVector.y
  return vector:create(x, y)
end

function vector:multiply(scalar)
  local x = self.x * scalar
  local y = self.y * scalar
  return vector:create(x, y)
end

function vector:rotate(angle)
  local x = math.cos(rotateAngle) * self.x - math.sin(rotateAngle) * self.y
  local y = math.sin(rotateAngle) * self.x + math.cos(rotateAngle) * self.y
  return vector:create(x, y)
end

function vector:getScalar()
  return math.sqrt(math.pow(self.x, 2) + math.pow(self.y, 2))
end

function vector:getAngle()
  if self:getScalar() > 0 then
    return math.atan2(self.y, self.x)
  else
    return 0
  end
end

function sumVectorTable(vectorTable)
  output = vector:create(0, 0)
  
  for i, v in ipairs(vectorTable) do
    output = output:add(v)
  end
  
  return output
end