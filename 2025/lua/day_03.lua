-- Please execute this script in the directory `2025/lua`. This will break otherwise
dofile("../lib/lua/input.lua")

-- finds the highest-value digit in the string from the specified boundaries
local function bounded_max (str, start, finish)
    local max, max_index = 0, -1
    for i = start, finish do
        local num = str:byte(i) - 48 -- ascii for 0
        if num > max then
            max = num
            max_index = i
        end
    end

    return max, max_index
end

local function get_max_joltage (str, digit_amount)
    local cur_digits = 0
    local joltage = 0

    local start, finish = 1, str:len() - (digit_amount - 1)
    repeat
        local max_digit, next_start = bounded_max(str, start, finish)
        
        joltage = joltage + max_digit * 10^(digit_amount - cur_digits - 1)
        cur_digits = cur_digits + 1
        start = next_start + 1
        finish = finish + 1
    until cur_digits == digit_amount

    return math.tointeger(joltage)
end

local function part_one ()
    local joltage_sum = 0

    for line in input(3) do
        joltage_sum = joltage_sum + get_max_joltage(line, 2)
    end

    return joltage_sum
end

local function part_two ()
    local joltage_sum = 0

    for line in input(3) do
        joltage_sum = joltage_sum + get_max_joltage(line, 12)
    end

    return joltage_sum

end

local function main ()
    print("DAY 03", "Lobby")
    print("PART 1", part_one())
    print("PART 2", part_two())
end

--------------------------------

main()
