local utils = {}

-- return a list of lines from the file in question
function utils.read_lines(file)
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    
    return lines
end

return utils