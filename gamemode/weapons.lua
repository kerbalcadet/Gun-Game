weaps = {}

if SERVER then
    
function WeapsAdd(cfg)

    if !file.Exists("gungame/weapons/"..cfg..".txt", "DATA") then return end

    weaps = {}
    local t = WeapFile()

    for i = 1, GG.Weapnum:GetInt() do
        local find = 0
        local v = t[math.random(#t)]

        for a, b in pairs(weaps) do
            if i > 1 && v[1] == b then find = 1 break end 
        end

        if find == 0 && v[2] != "disabled" then
            table.insert(weaps, {weap = v[1], type = v[2]})
        end
    end 
end

end