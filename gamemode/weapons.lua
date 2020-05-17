weaps = {}

if SERVER then
    
function GetRandomWeap(wtype)
    if !wtype then return end

    local t = WeapFile()
    local weapt = {}

    for k, weap in ipairs(t) do
        if weap[2] == wtype then table.insert(weapt, weap) end
    end

    if !weapt[1] then return end

    return weapt[math.random(#weapt)]
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
    "launcher"
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

end