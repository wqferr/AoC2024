local function read_pair(file)
  local curr_line = file:read "l"
  if curr_line then
    return curr_line:match "(%d+)%s+(%d+)"
  else
    return nil, nil
  end
end

local function read_lists(file)
  local first_list, second_list = {}, {}
  local first_value, second_value
  repeat
    first_value, second_value = read_pair(file)
    table.insert(first_list, first_value)
    table.insert(second_list, second_value)
  until not first_value
  return first_list, second_list
end

local function calc_dist(a, b)
  assert(#a == #b)
  local dist = 0
  for i = 1, #a do
    dist = dist + math.abs(a[i] - b[i])
  end
  return dist
end

local function main()
  local a, b = read_lists(io.input())
  table.sort(a)
  table.sort(b)
  local dist = calc_dist(a, b)
  print(dist)
end

main()
