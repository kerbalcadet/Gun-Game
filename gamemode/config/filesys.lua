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

function WeapFile(path, cfg, mode)
    if path && cfg && mode then

        local dir = "gungame/weapons/"..cfg..".txt"

        if !file.Exists(dir, "DATA") then 
            file.CreateDir("gungame/weapons")       --create file
            file.Write(dir, "")
        end

        local f, weps = file.Find(path.."*", "MOD")

        local t = {}
        if mode == "add" && file.Exists(dir, "DATA") then
            t = util.KeyValuesToTable(file.Read(dir, "DATA"))
        end

        for k, v in pairs(weps) do
            table.insert(t, {v, "generic"})         --add weap tables to blank table
        end

        print(util.TableToKeyValues(t))
    
        file.Write(dir, util.TableToKeyValues(t))
    end
    
    if file.Exists("gungame/weapons/"..GG.Cfg..".txt", "DATA") then return util.KeyValuesToTable(file.Read("gungame/weapons/"..GG.Cfg..".txt", "DATA"))
    else return {} end
end