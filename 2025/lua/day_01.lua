-- Please execute this script in the directory `2025/lua`. This will break otherwise
dofile("../lib/lua/input.lua")
dofile("../lib/lua/string_extensions.lua")

DAY = 1

local function part_one()
    local dial = 50
    local password = 0 -- number of times dial == 0

    for line in input.lines(DAY) do
        local direction, distance = line:slice(1)
        local sign = (direction == "R" and 1 or -1)
        local rotation = distance * sign

        dial = (dial + rotation) % 100
        if dial == 0 then password = password + 1 end
    end

    return password
end

local function part_two()
    local dial = 50
    local password = 0 -- number of times dial passes 0

    for line in input.lines(DAY) do
        local direction, distance = line:slice(1)
        local sign = (direction == "R" and 1 or -1)
        local rotation = distance * sign

        local full_rotations = distance // 100
        password = password + full_rotations

        -- clicks remaining after doing all full rotations. negative on L instructions
        local remainder = (distance % 100) * sign

        if (dial + rotation) % 100 == 0 then                   -- dial lands exactly at 0, same as before
            if remainder ~= 0 then password = password + 1 end -- avoid counting the first rotation twice
        elseif dial ~= 0 then                                  -- check if the remainder makes the dial pass 0 exactly once
            if dial + remainder < 0 or dial + remainder > 99 then password = password + 1 end
        end

        dial = (dial + rotation) % 100
    end

    return password
end

local function main()
    print("--- Day 01: Secret Entrance ---")
    print("Part 1: " .. part_one())
    print("Part 2: " .. part_two())
end

--------------------------------

main()
