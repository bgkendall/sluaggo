utf8case = {}


local utf8 = require("utf8")
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


function utf8case.lower(s)
    return map_utf8_string(s, utf8_uc_lc)
end

function utf8case.upper(s)
    return map_utf8_string(s, utf8_lc_uc)
end

function utf8case.lowerchar(c)
    return map_utf8_char(c, utf8_uc_lc)
end

function utf8case.upperchar(c)
    return map_utf8_char(c, utf8_lc_uc)
end


return utf8case
