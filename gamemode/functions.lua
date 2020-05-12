function GM:PlayerSelectSpawn()
    local t = ents.FindByClass("info_player_start")
    return t[math.random(#t)]
end

    --managespawns chat

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

    --weapons

function GiveWep(ply, lvl)
    ply:Give(weaps[lvl].weap, true)
    ply:GetWeapon(weaps[lvl].weap):SetClip1(weaps.ammo[weaps[lvl].type])
    ply:Give(weaps.Knife)
end

    --end

function End(ply)
    PrintMessage(4, ply:Nick().." Has won!")

    timer.Create("endwait", 5, 1, function()
        gmod.GetGamemode():Initialize()
        for k, v in pairs(player.GetAll()) do
            cleanup.CC_AdminCleanup(player.GetAll()[1], "gmod_admin_cleanup", {})
            initplayer(v)
            v:Spawn()
        end
    end)
end