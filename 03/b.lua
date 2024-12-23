-- UNFINISHED


---@param line string
---@return integer
local function sum_all_muls(line)
  local sum = 0
  local mul_pattern = "mul%((%d%d?%d?),(%d%d?%d?)%)"
  local enable_pattern = "do%(%)"
  local disable_pattern = "don't%(%)"
  local enabled = true
  local cursor = 1

  while cursor < #line do
    local next_mul = line:find(mul_pattern, cursor)
    if not next_mul then
      break
    end
    repeat
      local enable_position, enable_position_end = line:find(enable_pattern, cursor)
      local disable_position, disable_position_end = line:find(disable_pattern, cursor)

      enable_position = enable_position or math.huge
      disable_position = disable_position or math.huge

      if enable_position > next_mul and disable_position > next_mul then
        break
      end

      if enable_position < disable_position then
        cursor = enable_position_end or math.huge
        enabled = true
      else
        cursor = disable_position_end or math.huge
        enabled = false
      end

      cursor = cursor + 1
    until false
    local _, m_end, mul_a, mul_b = line:find(mul_pattern, next_mul)
    if enabled then
      sum = sum + tonumber(mul_a) * tonumber(mul_b)
    end
    cursor = m_end + 1
  end
  return sum
end

local function main()
  local line
  local sum = 0
  repeat
    line = io.read "l"
    if not line then
      break
    end
    sum = sum + sum_all_muls(line)
  until false
  print(sum)
end

main()
