-- Please execute this script in the directory `2025/lua`. This will break otherwise
dofile("../lib/lua/input.lua")
dofile("../lib/lua/string_extensions.lua")

DAY = 2

local function part_one()
    local id_sum = 0

    for line in input.lines(DAY) do
        for _, range in pairs(line:split(",")) do
            local lower, upper = range:match("(%d+)%-(%d+)") -- hell on earth

            for i = tonumber(lower), tonumber(upper) do
                if string.len(i) % 2 == 0 then
                    local x, y = string.slice(i, string.len(i) // 2)
                    if x == y then id_sum = id_sum + i end
                end
            end
        end
    end

    return id_sum
end

local function part_two()
    local id_sum = 0

    for line in input.lines(DAY) do
        for _, range in pairs(line:split(",")) do
            local lower, upper = range:match("(%d+)%-(%d+)") -- hell on earth

            for i = tonumber(lower), tonumber(upper) do
                for j = 1, string.len(i) // 2 do -- i has no divisors over i//2 besides itself
                    if string.len(i) % j == 0 then
                        local is_invalid = true
                        for cursor = 1, string.len(i) - j, j do
                            local x = string.sub(i, cursor, cursor - 1 + j)
                            local y = string.sub(i, cursor + j, cursor - 1 + 2 * j)

                            if x ~= y then
                                is_invalid = false
                                break
                            end
                        end

                        if is_invalid then
                            id_sum = id_sum + i
                            break
                        end
                    end
                end
            end
        end
    end

    return id_sum
end

local function main()
    print("--- Day 02: Gift Shop ---")
    print("Part 1: " .. part_one())
    print("Part 2: " .. part_two())
end

--------------------------------

main()
