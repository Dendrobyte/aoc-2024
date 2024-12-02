local utils = require("utils")

local file = "./data/day-1.txt"

lines = utils.read_lines(file)

local row_one = {}
local row_two = {}
for i, line in ipairs(lines) do
    -- print(line)
    nums = string.gmatch(line, "%d+") -- returns an iterator
    row_one[#row_one + 1] = nums()
    row_two[#row_two + 1] = nums()
end

-- Now we need to sort these rows
table.sort(row_one)
table.sort(row_two)

-- Compute distances for part 1
local distances = 0

for i, num in ipairs(row_one) do
    local distance = row_one[i] - row_two[i]
    if distance < 0 then
        distance = distance * -1
    end
    distances = distances + distance
end

print("PART 1 | Final distances summed: " .. distances)

-- For part two, we'll make a map out of the first list and increase a counter as we go through the second list
local first_list_map = {}
for _, num in ipairs(row_one) do
    first_list_map[num] = 0
end

for _, num in ipairs(row_two) do
    if first_list_map[num] == nil then
        first_list_map[num] = 0
    else
        first_list_map[num] = first_list_map[num] + 1
    end
end

local similarity_score = 0

for key, value in pairs(first_list_map) do
    similarity_score = similarity_score + key * value
end

print("PART 2 | Final similar score: " .. similarity_score)