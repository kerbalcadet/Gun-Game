    --player management--



function GiveWep(ply, lvl)
    ply:StripWeapons()
    ply:Give(weaps[lvl].weap, true)
    ply:GetWeapon(weaps[lvl].weap):SetClip1(weaps.ammo[weaps[lvl].type])
    ply:Give(weaps.Knife)
end

function GiveAmmo(ply)
    ply:GiveAmmo(weaps.ammo[weaps[att.Level].type], att:GetWeapon(weaps[att.Level].weap):GetPrimaryAmmoType())
end

function Promote(ply)
    ply.Level = ply.Level + 1
    ply:GiveWep(ply, ply.Level)
end

function Demote(ply)
    if ply.Level > 1 then ply.Level = ply.Level - 1 end
end

function GM:PlayerDeath(vic, inf, att)
    if att:IsPlayer() && att != vic then
        if att:GetActiveWeapon():GetClass() == weaps[att.Level].weap && att:Alive()  then       --normal kill
            if(att.Level > #weaps) then End(att)
            else
                Promote(att)
                GiveWep(att, att.Level) end
        else
            Demote(vic)        --knife kill
            GiveAmmo(att)
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
            initplayer(v)
            v:Spawn()
        end
    end)
end