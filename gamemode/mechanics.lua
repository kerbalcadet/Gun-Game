


    --player management--



function GiveWep(ply, lvl, time)
    local weap = weaps[lvl]
    local weapobj = ply:GetActiveWeapon()
    local t = time or 0.1

    if !weap then return end

    local a = 0
    if ply:Alive() && lvl > 1 && IsValid(ply:GetActiveWeapon()) then        -- a = extra ammo in previous weapon
        local w = ply:GetActiveWeapon()
        a = math.Clamp(math.floor((ply:GetAmmoCount(w:GetPrimaryAmmoType()) + w:Clip1())/ammo[weaps[lvl - 1].type]) - 1, 0, 10)
    end

    
    timer.Simple(t, function()
        weap = weaps[ply.Level]
        weapobj = ply:GetActiveWeapon()

        if lvl > 1 && weapobj:IsValid() && weapobj:GetClass() == weap.class then     --if weapon is the same as current
            GivePlyAmmo(ply)
            weapobj:detachAll()
            GiveAtts(ply)
            return
        end
        if ended then return end

        ply:StripWeapons()
        ply:StripAmmo()
        

        if weap.type == "explosive" then
            ply:Give(weap.class)

            weapobj = ply:GetWeapon(weap.class)           --seperated to give explosives ammo properly. Breaks otherwise.

            ply:GiveAmmo(a, weapobj:GetPrimaryAmmoType())
        else
            ply:Give(weap.class, true)

            weapobj = ply:GetWeapon(weap.class)

            if weap.type != "noammo" then
                weapobj = ply:GetWeapon(weap.class)
                local total = ammo[weap.type] + a*ammo[weap.type]
                local clip1 = math.Clamp(total, 0, weapobj:GetMaxClip1())

                GiveAtts(ply)
                weapobj:SetClip1(clip1) 
                ply:GiveAmmo(total - clip1, weapobj:GetPrimaryAmmoType())
            end
        end

        ply:Give(KNIFE)
    end)
end 



function GivePlyAmmo(ply)
    local weap = weaps[ply.Level]

    GiveAtts(ply)

    if ply:GetWeapon(weap.class) then ply:Give(weap.class, true) end                --for thrown explosives
    ply:GiveAmmo(ammo[weap.type], ply:GetWeapon(weap.class):GetPrimaryAmmoType())
end



function GiveAtts(ply)
    CustomizableWeaponry:removeAllAttachments(ply)
    if CFG ~="hl2" then ply:ConCommand("gg_client_add_att") end
end



function Promote(ply)
    if(ply.Level >= #weaps) then
        ply:StripWeapons()
        if !ended then End(ply) end
    end

    ply.Level = ply.Level + 1
    GiveWep(ply, ply.Level, 1)
end



function Demote(ply)
    if ply.Level > 1 then 
        ply.Level = ply.Level - 1
        
        if ply:Alive() then GiveWep(ply, ply.Level, 1) end
    end
end


hook.Add("PlayerDeath", "gg_ply_death", function(vic, inf, att)
    if ended then return end

    if att != vic then
        if att:GetActiveWeapon():GetClass() != KNIFE or inf:GetClass() != "player" or weaps[att.Level].class == KNIFE then       --normal kill (inf = player on melee or shoot)
            Promote(att)
        else
            Demote(vic)        --knife kill
            if att:Alive() then GivePlyAmmo(att) end
        end
    else        --suicide
        Demote(att)
    end
end)



    --miscellaneous--



hook.Add("Think", "killunderheight", function()
    if BARRIER:GetInt() != 0 then
        for k, v in pairs(player.GetAll()) do
            local dmg = DamageInfo()
            dmg:SetDamage(100)
            dmg:SetAttacker(v)
            dmg:SetInflictor(v)

            if v:GetPos().z*BARRIER:GetInt() < BARRIER_HEIGHT:GetInt() && v:Alive() then v:TakeDamageInfo(dmg) end
        end
    end
end)



    --ending--



function End(ply)

    if ply then PrintMessage(4, ply:Nick().." has won!")
    else PrintMessage(4, "Round ended") end

    ended = true

    timer.Create("endwait", 5, 1, function()
        gmod.GetGamemode():Initialize()
        for k, v in pairs(player.GetAll()) do
            game.CleanUpMap(false)
            gmod.GetGamemode():PlayerInitialSpawn(v)
            v:Spawn()
        end
    end)
end