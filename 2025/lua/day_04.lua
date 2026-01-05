-- Please execute this script in the directory `2025/lua`. This will break otherwise
dofile("../lib/lua/input.lua")

local ROLL_BYTE_VALUE <const> = 64
local EMPTY_BYTE_VALUE <const> = 46

local function part_one ()
    local rolls = 0

    local i, map = 1, {}
    for line in input(4) do
        map[i] = { line:byte(1, line:len()) }
        i = i + 1
    end

    for x, line in ipairs(map) do
        for y, pos in ipairs(line) do
            if pos == ROLL_BYTE_VALUE then
                local roll_count = 0

                for i = x-1, x+1 do
                    for j = y-1, y+1 do
                        local is_valid = -- ewwwww 
                            i > 0 and i <= #map and
                            j > 0 and j <= #line and
                            not (i == x and j == y)

                        if is_valid and map[i][j] == ROLL_BYTE_VALUE then
                            roll_count = roll_count + 1
                        end
                    end
                end

                if roll_count < 4 then rolls = rolls + 1 end
            end
        end
    end

    return rolls
end

local function part_two ()
    local rolls = 0

    local i, map = 1, {}
    for line in input(4) do
        map[i] = { line:byte(1, line:len()) }
        i = i + 1
    end

    repeat
        local index, coords_to_remove = 1, {}

        for x, line in ipairs(map) do
            for y, pos in ipairs(line) do
                if pos == ROLL_BYTE_VALUE then
                    local roll_count = 0

                    for i = x-1, x+1 do
                        for j = y-1, y+1 do
                            local is_valid = -- ewwwww 
                                i > 0 and i <= #map and
                                j > 0 and j <= #line and
                                not (i == x and j == y)

                            if is_valid and map[i][j] == ROLL_BYTE_VALUE then
                                roll_count = roll_count + 1
                            end
                        end
                    end

                    if roll_count < 4 then
                        rolls = rolls + 1

                        coords_to_remove[index] = { x, y }
                        index = index + 1
                    end
                end
            end
        end

        for _, coords in ipairs(coords_to_remove) do
            local x, y = coords[1], coords[2]
            map[x][y] = EMPTY_BYTE_VALUE
        end
    until #coords_to_remove == 0

    return rolls
end

local function main ()
    print("DAY 04", "Printing Department")
    print("PART 1", part_one())
    print("PART 2", part_two())
end

--------------------------------

main()
