


    --weap--



concommand.Add("gg_weap_readfolder", function(ply, cmd, args)
    if args[2] then 
        WeapReadFolder(args[1], args[2], args[3])
    else
        print("input folder path from garrysmod/ (addons/addon/lua/weapons/), mode (write or add), and optional cfg name") end
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



    --model--



concommand.Add("gg_model_readfolder", function(ply, cmd, args)
    if args[2] then 
        ModelReadFolder(args[1], args[2], args[3])
    else
        print("input folder path from garrysmod/ (addons/addon/models/weapons/), mode (write or add), and optional cfg name") end
end)



    --cfg--



concommand.Add("gg_cfg", function(ply, cmd, args)
    if args[1] && isstring(args[1]) then CFG = args[1]
    else print(CFG) end
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

concommand.Add("gg_weap_table", function(ply)
    if !ply.Debug then ply:PrintMessage(2, "you must be in debug mode to use this function") return end

    --[[
    for k, v in pairs(weaps) do 
        print("["..k.."]".." = "..v.class.." ("..v.type..")")
    end
    ]]

    PrintTable(weaps)
end)

concommand.Add("gg_att_table", function(ply)
    if !ply.Debug then ply:PrintMessage(2, "you must be in debug mode to use this function") return end

    --[[
    for k,v in pairs(GetAtts(ply:GetActiveWeapon():GetClass())) do
        for key, val in pairs(v) do
            print(k, val)
        end
    end
    ]]

    PrintTable(GetAtts(ply:GetActiveWeapon():GetClass()))
end)

concommand.Add("gg_att_rand", function(ply)
    if !ply.Debug then ply:PrintMessage(2, "you must be in debug mode to use this function") return end
    
    CustomizableWeaponry:removeAllAttachments(ply)
    --weap =ply:GetActiveWeapon()
    weap =ply:GetWeapon(weaps[ply.Level].class)
    atts =GetAtts(weap:GetClass())

    for k,v in pairs(atts) do
        if(math.random(0, 1) ==1) then
            local att =atts[k][math.random(#atts[k])]
            CustomizableWeaponry:giveAttachment(ply, att, true)
            net.Start("CW20_NEWATTACHMENTS")
            net.WriteString(att)
            net.Send(ply)
            weap:attachSpecificAttachment(att)
        end
    end
end)

concommand.Add("gg_client_add_att", function(ply)
    weap =ply:GetWeapon(weaps[ply.Level].class)
    
    for k, att in pairs(weaps[ply.Level].atts) do
        CustomizableWeaponry:giveAttachment(ply, att, true)
        net.Start("CW20_NEWATTACHMENTS")
        net.WriteString(att)
        net.Send(ply)
        weap:attachSpecificAttachment(att)
        if(CFG =="cw2" and (att =="am_magnum" or "am_matchgrade")) then weap:beginReload() end
    end
end)

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

concommand.Add("gg_spawn_clear", function(ply)
    Spawns = {}
    SpawnFile({})
end)

concommand.Add("gg_restart", function(ply)
    if !ply:IsAdmin() then ply:PrintMessage(2, "you must be an admin to use this function") return end

    End()
end)