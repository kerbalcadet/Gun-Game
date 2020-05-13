    --console--
concommand.Add("gg_readweapfolder", function(ply, cmd, args)
    if args[3] then WeapFile(args[1], args[2], args[3])
    else print("input folder path from garrysmod/ (addons/addon/lua/weapons), name of cfg, and mode (write or add)") end
end)

concommand.Add("gg_cfg", function(ply, cmd, args)
    if args[1] && isstring(args[1]) then GG.Cfg = args[1] end
end)



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