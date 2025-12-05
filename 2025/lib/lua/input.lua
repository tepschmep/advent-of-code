input = {}

-- Gets the input file associated with `day`.
--
-- Attempts to read from `[day].in` files in the `2025/input/` directory,
-- and expects days in the file names to be written with two digits (ie. `01.in`).
local function get_file(day)
    local guesses = { "2025/input", "input", "../input", "../../input" }

    day = tonumber(day)
    for _, line in ipairs(guesses) do
        local filename = string.format(
            "%s/%d%d.in",
            line,
            day // 10, -- first digit
            day % 10   -- second digit
        )

        local file = io.open(filename, "r") -- tests if the file exists
        if file then
            return file
        end
    end

    error("ERROR - File not found")
    return nil
end

-- Returns an array with each line of the input associated with `day`.
--
-- Throws an error if the input file cannot be found.
function input.get(day)
    local file = get_file(day)
    local input, i = {}, 1
    if file then
        repeat
            local line = file:read("l")
            input[i] = line
            i = i + 1
        until not line

        return input
    end

    return nil
end

-- Returns an iterator function for the input associated with `day`.
-- Allows for `for line in input.lines(day) do ... end`.
--
-- Throws an error if the input file cannot be found.
function input.lines(day)
    local input = input.get(day)

    local i = 0
    local n = #input -- length of input
    if input then
        return function()
            i = i + 1
            if i <= n then return input[i] end
        end
    end
end
