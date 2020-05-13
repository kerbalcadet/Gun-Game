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
    local cfg = "ins2"

    local dir = "gungame/weapons/"..cfg..".txt"

    if !file.Exists(dir, "DATA") then 
        file.CreateDir("gungame/weapons")
        file.Write(dir, "")
    end

    if path then
        local f, weps = file.Find(path.."*", "MOD")
        local t = {}

        for k, v in pairs(weps) do
            table.insert(t, {v, "generic"})
        end

        file.Write(dir, util.TableToKeyValues(t))
    else print("string path from /garrysmod needed") end
    
    return util.KeyValuesToTable(file.Read(dir, "DATA"))
end