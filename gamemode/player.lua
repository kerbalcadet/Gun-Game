util.AddNetworkString("death")

    --set up

function initplayer(ply)
    if !ply:IsPlayer() then return end
    
    ply.Level = 1
    ply.SpawnCt = 1
end

function setupplayer(ply)
    if !ply.Level then ply.Level = 1 end

    if SpawnFile()[1] then 
        local pt = SpawnFile()[math.random(#SpawnFile())]
        ply:SetPos(Vector(pt[1], pt[2], pt[3])) end

    ply:SetModel(pms[math.random(#pms)])
    ply:SetupHands()
    ply:SetHealth(GG.Health:GetInt())
    GiveWep(ply, ply.Level)
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