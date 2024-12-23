local function sum_all_muls(line)
  local sum = 0
  local pattern = "mul%((%d%d?%d?),(%d%d?%d?)%)"
  for a, b in line:gmatch(pattern) do
    sum = sum + tonumber(a) * tonumber(b)
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
