util.AddNetworkString("death")



    --set up



function GM:PlayerInitialSpawn(ply)
    ply.Level = 1
end

function GM:PlayerSpawn(ply)
    if !ply.Level then ply.Level = 1 end

    SetPos(ply)
    ply:SetModel(pms[math.random(#pms)])
    ply:SetupHands()
    ply:SetHealth(GG.Health:GetInt())
    GiveWep(ply, ply.Level)
end

function SetPos(ply)
    if SpawnFile()[1] then
        for i = 1, 15 do
            local pt = SpawnFile()[math.random(#SpawnFile())]
            local vec = (Vector(pt[1], pt[2], pt[3]))
            local close = 0

            for k, v in pairs(player.GetAll()) do
                if !v:Alive() then break end
                if vec:Distance(v:GetPos()) < GG.Spawndist:GetInt() then close = 1 break end
            end

            if close == 0 then ply:SetPos(vec) break
            elseif i > 14 then ply:SetPos(vec) end      
        end
    end
end



    --properties--



function GM:GetFallDamage(ply, speed)
    return GG.Falldmg
end