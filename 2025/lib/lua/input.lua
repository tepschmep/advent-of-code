-- Directories the get_file function attempts to check.
-- If the input file is not here, something is wrong.
local valid_directories <const> = { "2025/input", "input", "../input", "../../input" }

-- Gets the input file associated with the specified day.
-- Attempts to read from '{day}.in' files, where the day is written with two digits (ie. '01.in').
local function get_file (day)
    local file, err

    for _, guess in pairs(valid_directories) do
	local filename = string.format(
            "%s/%d%d.in",
	    guess,
	    day // 10, -- first digit
	    day % 10   -- second digit
	)

	file, err = io.open(filename, "r")
	if file then return file end
    end

    error("Error: " .. err)
end

-- Returns an iterator over the lines of an input associated with the specified day.
function input (day)
    local file = get_file(day)
	
    return function ()
        local line = file:read()

        if line then return line end
        file:close()
    end
end
