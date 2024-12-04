-- We could learn string parsing in lua
-- Or I could learn how to implement regex in lua, which is also way easier :)
-- Turns out I'll have to do both; grab the main mul(X, Y) groups and then parse those individually
-- https://www.lua.org/pil/20.1.html

local utils = require("utils")

local file = "./data/day-3.txt"

lines = utils.read_lines(file)

-- Parse the groups of "mul"
-- For part 2, we parse both patterns and only add mul groups after a do, skipping to the i after
-- If statements got a lil messy
groups = {}
mul_pattern = "mul%(%d+,%d+%)"
-- Starting with a "do", find the next "dont" and add everything in between there to the groups
-- Then find the next segment between a do and a dont
for li, line in ipairs(lines) do
    -- first and last represent bounds of a do and a dont
    start, finish = 1, string.find(line, "don't%(%)", 1)

    -- iterating for entire line
    while true do
        -- iterate to find all groups between this do and dont

        while start < finish do
            i, j = string.find(line, mul_pattern, start + 1)

            if i == nil or i > finish then -- in case it finds one after the next dont for trickiness?
                break
            end

            groups[#groups + 1] = string.sub(line, i, j)
            start = i
        end

        start, finish = string.find(line, "do%(%)", finish + 1), string.find(line, "don't%(%)", finish + 1)
        if start == nil then
            break
        end
        if finish == nil then
            finish = #line
        end
        
    end
end

-- print(table.concat(groups, ", "))

-- print("Groups are " .. table.concat(groups, ", "))
-- Sort of using regex-ish language instead of manual iteration
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

-- 159054045, 107519039 is too high
-- 76352604 is too low
-- 79384899, 110667964 (just... "not right")
-- 102467299
print("PART 2 | Total multiplied sum is " .. sum)

-- Part 1 approach, attempted to modify for part 2 but I have a better idea
-- for li, line in ipairs(lines) do
--     i = 0
--     do_count = 0
--     dont_count = 0
--     while true do
--         -- Get the next "don't" we encounter
--         local dont_idx, _ = string.find(line, "don't%(%)", i + 1)
--         dont_count = dont_count + 1
--         if dont_idx == nil then
--             dont_idx = #line
--         end
--         while i < dont_idx do
--             i, j = string.find(line, mul_pattern, i + 1) -- Need to start after the last found spot
--             if i == nil or i >= dont_idx then
--                 break
--             end
--             groups[#groups + 1] = string.sub(line, i, j)
--         end

--         local next_do_idx, next_do_end = string.find(line, "do%(%)", dont_idx + 1)
--         if next_do_idx == nil then
--             break
--         end
--         do_count = do_count + 1
--         i = next_do_end
--     end

--     print("Line " .. li .. " has " .. do_count .. " dos and " .. dont_count .. " donts")
-- end