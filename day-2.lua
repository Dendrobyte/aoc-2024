local utils = require("utils")

local file = "./data/day-2.txt"

lines = utils.read_lines(file)

-- Return true if a list of nums is safe
-- Part 2 modification:
--  If we find an unsafe value, let's remove it and rerun the function
function is_safe_report(nums, removed)
    local seen_bad_level = false
    -- See whether we are ascending or descending
    local is_asc = true

    if nums[1] > nums[2] then
        is_asc = false
    end

    -- Confirm all elements are ascending/descending
    for i = 1, #nums - 1 do
        local num_one = nums[i]
        local num_two = nums[i+1]
        
        if num_one == num_two then
            if not seen_bad_level then
                seen_bad_level = true
            end
        end

        -- Break early if we are not properly going in the right direction
        if is_asc and (num_one > num_two) then
            if not seen_bad_level then
                seen_bad_level = true
            end
        end
        if not is_asc and (num_one < num_two) then
            if not seen_bad_level then
                seen_bad_level = true
            end
        end
        

        -- Break early if the difference is too large
        local difference = num_one - num_two
        if difference < 0 then difference = difference * -1 end
        if difference > 3 then
            if not seen_bad_level then
                seen_bad_level = true
            end
        end

        -- If we've seen a bad level here, let's re-run the function
        -- We'll just retry without i and continue through whole list
        -- Just try removing i and i+1
        if seen_bad_level and not removed then
            local retry_one = {}
            local retry_two = {}
            for k = 1, #nums do
                if k ~= i then
                    table.insert(retry_one, nums[k])
                end
                if k ~= i+1 then
                    table.insert(retry_two, nums[k])
                end
            end
            
            local retry_is_safe = is_safe_report(retry_one, true) or is_safe_report(retry_two, true)
            print("For nums: " .. table.concat(nums, ", "))
            print("Retry 1: " .. table.concat(retry_one, ", "))
            print("Retry 2: " .. table.concat(retry_two, ", "))
            -- print("retry is safe: " .. tostring(retry_is_safe))
            -- print("----")
            if retry_is_safe then
                return true
            end
        end
    end

    if seen_bad_level then
        return false
    else
        return true
    end

end

local total_safe_reports = 0
local total_unsafe_reports = 0
for _, line in ipairs(lines) do
    local nums = {}
    local nums_iter = string.gmatch(line, "%d+")
    for num in nums_iter do
        nums[#nums + 1] = tonumber(num)
    end

     -- print("Checking: " .. table.concat(nums, ", "))
    
    local is_safe = is_safe_report(nums, false)
    if is_safe then
        total_safe_reports = total_safe_reports + 1
    else
        total_unsafe_reports = total_unsafe_reports + 1
    end
end

-- 342 is too low | 378 is too high
print("PART 2 | Total safe reports: " .. total_safe_reports)