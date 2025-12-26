-- Please execute this script in the directory `2025/lua`. This will break otherwise
dofile("../lib/lua/input.lua")

local function get_digit_count (num)
    return math.floor(math.log(num, 10) + 1)
end

local function get_digit (num, index, digit_count --[[optional, if you know it ahead of time]])
    digit_count = digit_count or get_digit_count(num)

    -- given a base-10 number with D digits, you can find its Kth digit by computing (number // 10^(D - K)) % 10
    return (num // 10^(digit_count - index)) % 10
end

local function part_one()
    local id_sum = 0
   
    local pattern = "(%d+)%-(%d+)" -- matches two digits separated by a '-' and captures both digits
    for line in input(2) do
        for lower, upper in string.gmatch(line, pattern) do
            for num = lower, upper do
                local digit_count = get_digit_count(num) 

                if digit_count % 2 == 0 then
                    local half = digit_count // 2
                    local is_invalid = true

                    for i = 1, half do 
                        local a, b = get_digit(num, i, digit_count), get_digit(num, i + half, digit_count)

                        if a ~= b then
                            is_invalid = false
                            break
                        end
                    end

                    if is_invalid then
                        id_sum = id_sum + num
                    end
                end
            end
        end
    end

    return math.tointeger(id_sum) -- in case it's still a float
end

local function part_two()
    local id_sum = 0

    local pattern = "(%d+)%-(%d+)" -- matches two digits separated by a '-' and captures both digits
    for line in input(2) do
        for lower, upper in string.gmatch(line, pattern) do
            for num = lower, upper do
                local digit_count = get_digit_count(num) 

                for mod = 1, digit_count // 2 do -- digit_count has no divisors over half besides itself
                    if digit_count % mod == 0 then
                        local segment = mod == 1 and 1 or digit_count // mod -- how many equally-sized segments we should divide the number in
                        local is_invalid = true

                        for n = 1, segment do -- check to see if every digit that leaves the same remainder when divided by n is equal. if this holds true, the number is invalid
                            local j = n
                            repeat 
                                local a, b = get_digit(num, j, digit_count), get_digit(num, j + segment, digit_count)

                                if a ~= b then
                                    is_invalid = false
                                    break
                                end

                                j = j + segment
                            until j + segment > digit_count

                            if not is_invalid then break end
                        end

                        if is_invalid then
                            id_sum = id_sum + num
                            break
                        end
                    end
                end
            end
        end
    end

    return math.tointeger(id_sum)
end

local function main()
    print("--- Day 02: Gift Shop ---")
    print("Part 1: " .. part_one())
    print("Part 2: " .. part_two())
end

--------------------------------

main()
