


    --cfg--



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



    --debug--



concommand.Add("gg_debug", function(ply)
    local t = {[true] = "enabled", [false] = "disabled"}

    if ply:IsAdmin() then
        ply.Debug = !ply.Debug
        ply:PrintMessage(2, t[ply.Debug])
    else print("you must be an admin to use this function")
    end
end)

function GM:PlayerNoClip(ply, bool)
    return ply.Debug
end

concommand.Add("gg_level", function(ply, cmd, args)

    if !ply.Debug then ply:PrintMessage(2, "you must be in debug mode to use this function") return end
    arg = args[1]

    if tonumber(arg) then
        ply.Level = tonumber(arg)
        GiveWep(ply, ply.Level)
    elseif arg == "up" then
        Promote(ply)
    elseif arg == "down" then
        Demote(ply)
    elseif arg then ply:PrintMessage(2, "input either <level>, <up> or <down>") return end

    ply:PrintMessage(2, ply.Level)
end)



    --gameplay--



concommand.Add("gg_spawn", function(ply)
    if !ply:IsAdmin() then ply:PrintMessage(2, "you must be an admin to use this function") return end

    table.insert(Spawns, ply:GetPos():ToTable())
    SpawnFile(Spawns)
end)

concommand.Add("gg_spawnclear", function(ply)
    Spawns = {}
    SpawnFile({})
end)

concommand.Add("gg_restart", function(ply)
    if !ply:IsAdmin() then ply:PrintMessage(2, "you must be an admin to use this function") return end

    End()
end)