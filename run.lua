#!./lua

local status_code = {
  INVALID_USAGE = 1,
  INVALID_CALL = 2,
  UNIMPLEMENTED_PROBLEM = 3,
  INPUT_DNE = 4
}

local posix = require "posix"
local function exists(path)
  return posix.stat(path) ~= nil
end

if not exists "./lua" then
  print("This program must be run within a `luarocks init` environment")
  os.exit(status_code.INVALID_USAGE)
end

local problem_nr, part = ...
if not problem_nr or not part then
  local this_script = debug.getinfo(function() end).source:sub(2)
  print(("Usage: ./lua %s problem_nr part"):format(this_script))
  os.exit(status_code.INVALID_USAGE)
end

if not tonumber(problem_nr) then
  print "Problem number must be a number"
  os.exit(status_code.INVALID_CALL)
end

if #problem_nr < 2 then
  problem_nr = "0" .. problem_nr
end

if part ~= "ae" and part ~= "ai" and part ~= "be" and part ~= "bi" then
  print 'Part must be one of "ae", "ai", "be", or "bi"'
  os.exit(status_code.INVALID_CALL)
end

local script_path = ("./%s/%s.lua"):format(problem_nr, part:sub(1, 1))
if not exists(script_path) then
  print("Script does not exist: " .. script_path)
  os.exit(status_code.UNIMPLEMENTED_PROBLEM)
end

local input_name
if part:sub(2) == "e" then
  input_name = "example"
else
  input_name = "input"
end
local input_path = ("./%s/%s"):format(problem_nr, input_name)
if not exists(input_path) then
  print("Input file does not exist: " .. input_path)
  os.exit(status_code.INPUT_DNE)
end


local cmd = ("./lua %s <%s"):format(script_path, input_path)
print(cmd)
do
  local p = assert(io.popen(cmd, "r"))
  local s = assert(p:read("a"))
  p:close()
  io.write(s)
end
