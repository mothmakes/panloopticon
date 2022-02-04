function Initialize()
    dofile(SKIN:GetVariable('@').."Scripts\\Lib\\utils.lua")
end

function updateAccentColor()
    os.execute('C:\\Windows\\System32\\reg.exe query HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Accent /v AccentPalette > '..SKIN:GetVariable('@').."Scripts\\registry_dump")
    local f = io.open(SKIN:GetVariable('@')..'Scripts\\registry_dump',"r")
    local f_string = f:read("*all")
    f:close()

    local v = io.open(SKIN:GetVariable('@')..'Scripts\\variables.csv',"r")
    local v_string = v:read("*all")
    v:close()

    local new_f_string = f_string:gsub(".*REG_BINARY","")
    new_f_string = new_f_string:gsub("[%c%s]","")

    local r = new_f_string:sub(1,2)
    local g = new_f_string:sub(3,4)
    local b = new_f_string:sub(5,6)

    print("Accent color: "..r..g..b)

    local new_v_string = v_string:gsub("AccentColor,%x%x%x%x%x%x","AccentColor,"..r..g..b)

    r = string.format("%x",255-tonumber(r,16))
    if(#r == 1) then
        r = "0"..r
    end
    g = string.format("%x",255-tonumber(g,16))
    if(#g == 1) then
        g = "0"..g
    end
    b = string.format("%x",255-tonumber(b,16))
    if(#b == 1) then
        b = "0"..b
    end

    new_f_string = r..g..b

    print("Contrast color: "..new_f_string)

    new_v_string = new_v_string:gsub("ContrastColor,%x%x%x%x%x%x","ContrastColor,"..r..g..b)

    local v_new = io.open(SKIN:GetVariable('@')..'Scripts\\variables.csv',"w")
    v_new:write(new_v_string)
    v_new:close()
end