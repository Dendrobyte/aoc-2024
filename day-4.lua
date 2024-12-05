local utils = require("utils")

local file = "./data/day-4.txt"

lines = utils.read_lines(file)

grid = {}
for _, line in ipairs(lines) do
    row = {}
    for i = 1, #line do
        local char = string.sub(line, i, i)
        row[#row + 1] = char
    end

    grid[#grid + 1] = row
end

function print_grid()
    for _, row in ipairs(grid) do
        for _, char in ipairs(row) do
            io.write(char)
        end
        print()
    end
end

-- Presumably we need to tally +2 for two Ss adjacent to one A?
sequence = { 'X', 'M', 'A', 'S' }
moves = { {0, 1}, {1, 1}, {1, 0}, {1, -1}, {0, -1}, {-1, -1}, {-1, 0}, {-1, 1} }
function do_search(i, j, curr)
    local curr_char = sequence[curr]
    print("Running search on current char " .. curr_char)
    local found_tally = 0

    if curr_char == 'A' then
        for _, move in ipairs(moves) do
            local x, y = i+move[1], j+move[2]
            if x < 1 or y < 1 or x > #grid or y > #grid[1] then
                -- print("outta bounds")
            else
                local look_at = grid[x][y]
                if look_at == 'S' then
                    found_tally = found_tally + 1
                    print("Found an S")
                end
            end
        end
    else -- if it's M, LOL
        for _, move in ipairs(moves) do
            
            local x, y = i + move[1], j + move[2]
            if x < 1 or y < 1 or x > #grid or y > #grid[1] then
                -- print("outta bounds")
            else
                local look_at = grid[x][y]
                if look_at == sequence[curr+1] then
                    found_tally = found_tally + do_search(i, j, curr+1)
                end
            end
        end
    end

    return found_tally
end

-- DFS
found_xmas = 0
for r, row in ipairs(grid) do
    for c, char in ipairs(row) do
        if char == 'X' then
            found_xmas = found_xmas + do_search(r, c, 2)
        end
    end
end

print("PART 1 | Found " .. found_xmas .. " instances of XMAS")