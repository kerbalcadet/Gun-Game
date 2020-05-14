


    --console--



concommand.Add("gg_weap_readfolder", function(ply, cmd, args)
    if args[2] then 
        WeapReadFolder(args[1], args[2], args[3])
    else
        print("input folder path from garrysmod/ (addons/addon/lua/weapons), mode (write or add), and optional cfg name") end
end)

concommand.Add("gg_weap_add", function(ply, cmd, args)
    if args[1] && WeapValid(args[1]) then
        WeapFileAdd(args[1], args[2], args[3])
    else print("input weapon class then optional type and cfg name") end
end)

concommand.Add("gg_weap_remove", function(ply, cmd, args)
    if args[1] then
        WeapFileRemove(args[1], args[2])
    else print("input weapon class then optional cfg name") end
end)

concommand.Add("gg_weap_type", function(ply, cmd, args)
    if args[1] then
        WeapFileType(args[1], args[2], args[3])
    else print("input weapon class then type and optional cfg name") end
end)

concommand.Add("gg_cfg", function(ply, cmd, args)
    if args[1] && isstring(args[1]) then GG.Cfg = args[1]
    else print(GG.Cfg) end
end)

concommand.Add("gg_cfg_clear", function(ply, cmd, args)
    if args[1] then
        WeapFileClear(args[1])
    else print("input cfg name to delete") end
end)

concommand.Add("gg_cfg_read", function(ply, cmd, args)
    WeapFileRead(args[1])
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