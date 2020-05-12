    --console--







    --chat--



hook.Add("PlayerSay", "spawn commands", function(ply, str)

    if string.Trim(str) == "gg.spawncreate" then 
        table.insert(Spawns, ply:GetPos():ToTable())
        return ""
    elseif string.Trim(str) == "gg.spawnclear" then 
        Spawns = {}
        return ""
    elseif string.Trim(str) == "gg.restart" then End(ply) 
        return ""
    elseif string.Trim(str) == "gg.throne" then
        ply.throne = 1

        ply:SetVelocity(Vector(0, 0, 400))
--[[
        for i = 1, 4 do
            local t = player.CreateNextBot("thronelifter."..i)
            local a = i*90

            t:Spawn()
            t:SetPos(ply:GetPos() + Vector(math.sin(a), math.cos(a), 0))
        end
]]--
        return ""
    end
end)