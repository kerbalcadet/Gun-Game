


    --player management--



function GiveWep(ply, lvl)
    ply:StripWeapons()
    ply:Give(weaps[lvl].weap, true)
    ply:GetWeapon(weaps[lvl].weap):SetClip1(ammo[weaps[lvl].type])
    ply:Give(GG.Knife)
end

function GivePlyAmmo(ply)
    local wep = ply:GetWeapon(weaps[ply.Level].weap)

    ply:GiveAmmo(ammo[weaps[ply.Level].type], ply:GetWeapon(weaps[ply.Level].weap):GetPrimaryAmmoType())
end

function Promote(ply)
    ply.Level = ply.Level + 1
    GiveWep(ply, ply.Level)
end

function Demote(ply)
    if ply.Level > 1 then ply.Level = ply.Level - 1 end
end

function GM:PlayerDeath(vic, inf, att)

    if att:IsPlayer() && att != vic then
        if att:GetActiveWeapon():GetClass() != GG.Knife && att:Alive()  then       --normal kill
            if(att.Level >= #weaps) then
                att:StripWeapons()
                End(att)

            else Promote(att) end
        else
            Demote(vic)        --knife kill
            if att:Alive() then GivePlyAmmo(att) end
        end
    elseif att == vic then        --suicide
        Demote(vic)
    end

    net.Start("death")      --deathnotice to cl
    net.WriteEntity(vic)
    net.WriteEntity(inf)
    net.WriteEntity(att)
    net.Broadcast()
end



    --miscellaneous--



hook.Add("Think", "killunderheight", function()
    if GG.Barrier:GetInt() != 0 then
        for k, v in pairs(player.GetAll()) do
            local dmg = DamageInfo()
            dmg:SetDamage(100)
            dmg:SetAttacker(v)
            dmg:SetInflictor(v)

            if v:GetPos().z*GG.Barrier:GetInt() < GG.Barrierheight:GetInt() && v:Alive() then v:TakeDamageInfo(dmg) end
        end
    end
end)



    --ending--



function End(ply)
    PrintMessage(4, ply:Nick().." Has won!")

    timer.Create("endwait", 5, 1, function()
        gmod.GetGamemode():Initialize()
        for k, v in pairs(player.GetAll()) do
            game.CleanUpMap(true)
            gmod.GetGamemode():PlayerInitialSpawn(v)
            v:Spawn()
        end
    end)
end