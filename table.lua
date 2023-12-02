local table = table
local ctable = {}
local meta = {}
meta.__index = table
setmetatable(ctable, meta)

function ctable.random<T>(haystack:{T}): {T}
    local length = #haystack
    
    return haystack[math.random(1, length)]
end

return ctable
