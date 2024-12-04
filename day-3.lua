-- We could learn string parsing in lua
-- Or I could learn how to implement regex in lua, which is also way easier :)
-- Turns out I'll have to do both; grab the main mul(X, Y) groups and then parse those individually
-- https://www.lua.org/pil/20.1.html

local utils = require("utils")

local file = "./data/day-3.txt"

lines = utils.read_lines(file)

-- Parse the groups of "mul"
groups = {}
mul_pattern = "mul%(%d+,%d+%)"
for _, line in ipairs(lines) do
    local i = 0
    while true do
        i, j = string.find(line, mul_pattern, i + 1) -- Need to start after the last found spot
        if i == nil then
            break
        end
        groups[#groups + 1] = string.sub(line, i, j)
    end
end

function parse_mul(mul_str)
    i_1 = string.find(mul_str, "%(") + 1
    i_2 = string.find(mul_str, ",") - 1
    j_1 = string.find(mul_str, ",") + 1
    j_2 = string.find(mul_str, "%)") - 1
    num_one = tonumber(string.sub(mul_str, i_1, i_2))
    num_two = tonumber(string.sub(mul_str, j_1, j_2))
    return num_one * num_two
end

local sum = 0
for _, s in ipairs(groups) do
    sum = sum + parse_mul(s)
end

print("PART 1 | Total multiplied sum is " .. sum)