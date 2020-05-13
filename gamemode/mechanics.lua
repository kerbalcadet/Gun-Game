


    --player management--



function GiveWep(ply, lvl)
    local weap = weaps[lvl]

    local a = 0
    if ply:Alive() && lvl > 1 && IsValid(ply:GetActiveWeapon()) then
        local w = ply:GetActiveWeapon()
        a = math.Clamp(math.floor((ply:GetAmmoCount(w:GetPrimaryAmmoType()) + w:Clip1())/ammo[weaps[lvl - 1].type]) - 1, 0, 10)
    end
    

    ply:StripWeapons()
    ply:StripAmmo()
    ply:Give(weaps[lvl].class, true)
    ply:Give(GG.Knife)

    weapobj = ply:GetWeapon(weap.class)

    if weap.type == "explosive" then
        ply:GiveAmmo(a, weapobj:GetPrimaryAmmoType())
    else
        local total = ammo[weap.type] + a*ammo[weap.type]
        local clip1 = math.Clamp(total, 0, weapobj:GetMaxClip1())
        weapobj:SetClip1(clip1) 
        ply:GiveAmmo(total - clip1, weapobj:GetPrimaryAmmoType())
        
        print(ammo[weap.type].." default,"..a.."*"..ammo[weap.type].." extra")

    end

end 

function GivePlyAmmo(ply)
    local weap = weaps[ply.Level]

    ply:GiveAmmo(ammo[weap.type], ply:GetWeapon(weap.class):GetPrimaryAmmoType())
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
            game.CleanUpMap(false)
            gmod.GetGamemode():PlayerInitialSpawn(v)
            v:Spawn()
        end
    end)
end