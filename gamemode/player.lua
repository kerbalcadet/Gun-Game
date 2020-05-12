util.AddNetworkString("death")

    --set up

function initplayer(ply)
    if !ply:IsPlayer() then return end
    
    ply.Level = 1
    ply.SpawnCt = 1
end

function setupplayer(ply)
    if !ply.Level then ply.Level = 1 end

    SetPos(ply)
    ply:SetModel(pms[math.random(#pms)])
    ply:SetupHands()
    ply:SetHealth(GG.Health:GetInt())
    GiveWep(ply, ply.Level)
end

function SetPos(ply)
    if SpawnFile()[1] then

        for i = 1, 100 do
            local pt = SpawnFile()[math.random(#SpawnFile())]
            local vec = (Vector(pt[1], pt[2], pt[3]))
            local close = 0

            for k, v in pairs(player.GetAll()) do
                if !v:Alive() then break end
                if vec:Distance(v:GetPos()) < GG.Spawndist:GetInt() then close = 1 break end
            end
            
            if close == 0 then ply:SetPos(vec)
            elseif i > 99 then ply:SetPos(vec) end
        end
    end
end

    --death

function handledeath(vic, inf, att)
    if att:IsPlayer() && att != vic then

        if att:GetActiveWeapon():GetClass() == weaps[att.Level].weap && att:Alive() then
            att:StripWeapons()

            att.Level = att.Level + 1
            if(att.Level > #weaps) then End(att)
            else GiveWep(att, att.Level) end

        elseif att:IsPlayer() then 
            if(vic.Level > 1) then vic.Level = vic.Level - 1 end

            att:GiveAmmo(weaps.ammo[weaps[att.Level].type], att:GetWeapon(weaps[att.Level].weap):GetPrimaryAmmoType())
        end
    end

    --death notice

    net.Start("death")
    net.WriteEntity(vic)
    net.WriteEntity(inf)
    net.WriteEntity(att)
    net.Broadcast()
end

hook.Add("Think", "killunderheight", function()
    if GG.Barrier:GetInt() != 0 then
        for k, v in pairs(player.GetAll()) do
            if v:GetPos().z*GG.Barrier:GetInt() < GG.Barrierheight:GetInt() && v:Alive() then v:Kill() end
        end
    end
end)