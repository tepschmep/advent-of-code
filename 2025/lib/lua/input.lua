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
	local file <close> = get_file(day)
	
	local i, lines = 1, {}
	repeat
		line = file:read()
		lines[i] = line
		i = i + 1
	until line == nil

	file:close()

	-- iterator function 
	counter = 0
	return function ()
		counter = counter + 1
		if counter <= #lines then return lines[counter] end
	end
end
