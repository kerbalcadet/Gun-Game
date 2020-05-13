function SpawnFile(tbl)
    local dir = "gungame/spawns/"..game.GetMap()..".txt"

    if !file.Exists(dir, "DATA") then 
        file.CreateDir("gungame/spawns")
        file.Write(dir, "")
    end

    if tbl then
        file.Write(dir, util.TableToKeyValues(tbl))
    end
    
    return util.KeyValuesToTable(file.Read(dir, "DATA"))
end

function WeapFile(path, cfg)
    if path then
        if !cfg then print("func WeapFile needs CFG!") return end

        local dir = "gungame/weapons/"..cfg..".txt"

        if !file.Exists(dir, "DATA") then 
            file.CreateDir("gungame/weapons")
            file.Write(dir, "")
        end

        local f, weps = file.Find(path.."*", "MOD")
        local t = {}

        for k, v in pairs(weps) do
            table.insert(t, {v, "generic"})
        end

        file.Write(dir, util.TableToKeyValues(t))
    end
    
    return util.KeyValuesToTable(file.Read("gungame/weapons/"..GG.Cfg..".txt", "DATA"))
end