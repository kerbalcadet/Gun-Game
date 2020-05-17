weaps = {}
    
function GetRandomWeap(wtype)
    local t = WeapFile()
    local weap = {}

    if !wtype then return end

    for i = 1, #t*3 do
        local k = math.random(#t)
        if t[k][2] == wtype then 
            weap = t[k]
            break
        end
    end

    if !weap[1] then return end

    return weap
end

function WeapsAdd()
    weaps ={}

    if !file.Exists("gungame/weapons/"..CFG..".txt", "DATA") then return end
    
    local types = {
    "pistol",
    "shotgun",
    "smg",
    "semiauto",
    "generic",
    "assault",
    "lmg",
    "sniper",
    "explosive",
    "launcher",
    "noammo"
    }
    
    local valid = {}
    for k, wtype in pairs(types) do
        if GetRandomWeap(wtype) then table.insert(valid, wtype) end
    end

    local w_num = WEAP_NUM:GetInt()

    for k, wtype in pairs(valid) do
        for i = 1, math.ceil((w_num - #weaps)/(#valid - k + 1), 0) do
            if #weaps >= w_num then return end

            local weap = GetRandomWeap(wtype)

            if weap then table.insert(weaps, {class = weap[1], type = weap[2]}) end
        end
    end
end

function WeapValid(str)
    local ply = player.GetAll()[1]
    if !ply then
        print("error: need valid player")
        return
    end

    if ply:Give(str, true) != NULL then 
        ply:StripWeapon(str)
        return true
    elseif ply:GetWeapon(str):IsValid() then
        return true
    else
        print("invalid weapon!")
        return false
    end
end
