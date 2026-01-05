-- Please execute this script in the directory `2025/lua`. This will break otherwise
dofile("../lib/lua/input.lua")

local function add_range (ranges, to_add, index)
    index = index or 1

    for i = index, #ranges do
        local range = ranges[i]

        if range.lower <= to_add.lower and to_add.upper <= range.upper then
            return
        end

        if to_add.lower <= range.lower and range.upper <= to_add.upper then
            local new_range

            if to_add.lower ~= range.lower then
                new_range = { lower = to_add.lower, upper = range.lower - 1 }
                add_range(ranges, new_range, i + 1)
            end
            
            if to_add.upper ~= range.upper then
                new_range = { lower = range.upper + 1, upper = to_add.upper }
                add_range(ranges, new_range, i + 1)
            end

            return
        end

        if range.lower <= to_add.lower and to_add.lower <= range.upper then
            to_add.lower = range.upper + 1
        end

        if range.lower <= to_add.upper and to_add.upper <= range.upper then
            to_add.upper = range.lower - 1
        end
    end

    table.insert(ranges, to_add)
end

local function part_one ()
    local fresh_ids = 0

    local ingredient_ranges = {}

    local pattern = "(%d+)%-(%d+)"
    for line in input(5) do
        local lower, upper = string.match(line, pattern)
        
        if lower and upper then
            local range = { lower = tonumber(lower), upper = tonumber(upper) }
            table.insert(ingredient_ranges, range)
        else
            local id = tonumber(line) or -1 -- thank you blank line !

            for _, range in ipairs(ingredient_ranges) do 
                if id >= range.lower and id <= range.upper then
                    fresh_ids = fresh_ids + 1
                    break
                end
            end
        end
    end

    return fresh_ids      
end

local function part_two ()
    local fresh_ids = 0
    local ingredient_ranges = {}

    local pattern = "(%d+)%-(%d+)"
    for line in input(5) do
        local lower, upper = string.match(line, pattern)

        if lower and upper then
            local range = { lower = tonumber(lower), upper = tonumber(upper) }
            add_range(ingredient_ranges, range)
        end
    end

    for _, range in ipairs(ingredient_ranges) do
        fresh_ids = fresh_ids + 1 + range.upper - range.lower
    end

    return fresh_ids
end

local function main ()
    print("DAY 05", "Cafeteria")
    print("PART 1", part_one())
    print("PART 2", part_two())
end

--------------------------------

main()
