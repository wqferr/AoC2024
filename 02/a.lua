local Record = {}
local Record_mt = { __index = Record }

function Record.new(levels)
  local rec = { levels = levels }
  setmetatable(rec, Record_mt)
  return rec
end

function Record.read(file)
  local line = file:read "l"
  if not line then
    return nil
  end
  local levels = {}
  for level in line:gmatch "(%d+)" do
    table.insert(levels, tonumber(level))
  end
  return Record.new(levels)
end

function Record:_is_safely_monotone(decreasing)
  for i = 2, #self.levels do
    local delta = self.levels[i] - self.levels[i-1]
    if decreasing then
      delta = -delta
    end
    if delta < 1 or delta > 3 then
      return false
    end
  end
  return true
end

function Record:is_safe()
  return self:_is_safely_monotone(false) or self:_is_safely_monotone(true)
end

local function main()
  local safe_count = 0
  repeat
    local rec = Record.read(io.input())
    if not rec then
      break
    end
    if rec:is_safe() then
      safe_count = safe_count + 1
    end
  until false
  print(safe_count)
end

main()
