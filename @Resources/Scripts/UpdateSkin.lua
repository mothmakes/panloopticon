function Initialize()
    dofile(SKIN:GetVariable('@').."Scripts\\Lib\\utils.lua")
end

function updateSkin()
    local f = SKIN:GetVariable('@').."Scripts\\variables.csv"
    local variables = {}
    for line in io.lines(f) do
        local split = split_with_comma(line)
        variables[split[1]] = split[2]
    end
    for k,v in pairs(variables) do
        SKIN:Bang("!SetVariable",k,v)
    end
end