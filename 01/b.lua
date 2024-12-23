local function read_pair(file)
  local curr_line = file:read "l"
  if curr_line then
    return curr_line:match "(%d+)%s+(%d+)"
  else
    return nil, nil
  end
end

local function zero()
  return 0
end
local default_to_0_mt = {__index = zero}

local function read_lists(file)
  local first_list, second_list_freqs = {}, {}
  setmetatable(second_list_freqs, default_to_0_mt)
  local first_value, second_value
  repeat
    first_value, second_value = read_pair(file)
    if not first_value then
      break
    end
    assert(second_value)

    table.insert(first_list, first_value)
    second_list_freqs[second_value] = second_list_freqs[second_value] + 1
  until false
  return first_list, second_list_freqs
end

local function calc_similarity(a, b_freqs)
  local sim = 0
  for _, v in ipairs(a) do
    sim = sim + v * b_freqs[v]
  end
  return sim
end

local function main()
  local a, b_freqs = read_lists(io.input())
  local dist = calc_similarity(a, b_freqs)
  print(dist)
end

main()
