local utils = require("utils")

local file = "./data/day-2.txt"

lines = utils.read_lines(file)

-- Return true if a list of nums is safe
function is_safe_report(nums)
    -- See whether we are ascending or descending
    local is_asc = true

    if nums[1] > nums[2] then
        is_asc = false
    end

    -- Confirm all elements are ascending/descending
    for i = 1, #nums - 1 do
        num_one = nums[i]
        num_two = nums[i+1]
        if num_one == num_two then
            return false
        end

        -- Break early if we are not properly going in the right direction
        if is_asc then
            if num_one >= num_two then
                return false
            end
        else
            if num_one <= num_two then
                return false
            end
        end

        -- Break early if the difference is too large
        local difference = num_one - num_two
        if difference < 0 then difference = difference * -1 end
        if difference < 1 or difference > 3 then
            print("The difference between " .. num_one .. " and " .. num_two .. " breaks the rules.")
            print("Nums [" .. table.concat(nums, ",") .. "] is unsafe")
            return false
        end

    end

    return true

end

local total_safe_reports = 0
for _, line in ipairs(lines) do
    local nums = {}
    local nums_iter = string.gmatch(line, "%d+")
    for num in nums_iter do
        nums[#nums + 1] = num
    end

     -- print("Checking: " .. table.concat(nums, ", "))
    
    local is_safe = is_safe_report(nums)
    if is_safe then
        total_safe_reports = total_safe_reports + 1
    end
end

-- 247 too low
-- 385 too high
print("PART 1 | Total safe reports: " .. total_safe_reports)