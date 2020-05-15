weaps = {}

if SERVER then
    
function WeapsAdd(cfg)

    if !file.Exists("gungame/weapons/"..cfg..".txt", "DATA") then return end

    weaps = {}
    local t = WeapFile()

    for i = 1, 100 do
        if #weaps >= GG.Weapnum:GetInt() then break end

        local v = t[math.random(#t)]

        if v[2] != "disabled" then
            table.insert(weaps, {class = v[1], type = v[2]})
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