-- Adds the following functions to the utf8 library:
--  * lower - converts UTF-8 string to lowercase
--  * upper - converts UTF-8 string to uppercase
--  * lowerchar - converts the first character of a UTF-8 string to lowercase
--  * upperchar - converts the first character of a UTF-8 string to uppercase

require("utf8data")


local function map_utf8_char(c, map)
    return (map[c] or c)
end

local function map_utf8_string(s, map)

    local mapped = ""

    for _, code in utf8.codes(s) do
        mapped = mapped .. map_utf8_char(utf8.char(code), map)
    end

    return mapped
end


local function utf8case_lower(s)
    return map_utf8_string(s, utf8_uc_lc)
end

if not utf8.lower then
    utf8.lower = utf8case_lower
end


local function utf8case_upper(s)
    return map_utf8_string(s, utf8_lc_uc)
end

if not utf8.upper then
    utf8.upper = utf8case_upper
end


local function utf8case_lowerchar(c)
    return map_utf8_char(c, utf8_uc_lc)
end

if not utf8.lowerchar then
    utf8.lowerchar = utf8case_lowerchar
end


local function utf8case_upperchar(c)
    return map_utf8_char(c, utf8_lc_uc)
end

if not utf8.upperchar then
    utf8.upperchar = utf8case_upperchar
end
