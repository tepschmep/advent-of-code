-- Returns the character at `pos` in `str`.
function string.at(str, pos)
    return str:sub(pos, pos)
end

-- Returns a number and an iterator function such that the loop
-- `for i, char in str:chars() do ... end` iterates through the
-- pairs `(pos, str:at(pos))`.
function string.chars(str)
    local i = 0
    local n = str:len()

    return function()
        i = i + 1
        if i <= n then return i, str:at(i) end
    end
end

-- Slices `str` at `pos` and returns the substrings created.
function string.slice(str, pos)
    return string.sub(str, 1, pos), string.sub(str, pos + 1)
end

function string.split(str, delimiter)
    local tokens = {}

    local pos = 1
    for index, char in str:chars() do
        if char == delimiter then
            table.insert(tokens, str:sub(pos, index - 1))
            pos = index + 1
        end
    end

    table.insert(tokens, str:sub(pos)) -- add token after the last delimiter

    return tokens
end
