weaps = {
    Knife = "weapon_crowbar",
    ammo = {
        ["pistol"] = 5,
        ["smg"] = 5,
        ["shotgun"] = 1,
        ["semiauto"] = 4,
        ["assault"] = 6,
        ["lmg"] = 5,
        ["sniper"] = 1,
        ["explosive"] = 1,
        ["generic"] = 5 },
}

if SERVER then
    
function WeapsAdd(cfg)
    if !file.Exists("gungame/weapons/"..cfg..".txt", "DATA") then return end

    local t = WeapFile()
    for i = 1, GG.Weapnum do
        local v = t[i]

        if v[2] != "disabled" then
            table.insert(weaps, {weap = v[1], type = v[2]})
        end
    end
end