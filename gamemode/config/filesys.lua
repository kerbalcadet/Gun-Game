


    --spawn file--


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



    --weap file--



function WeapFile(argcfg)
    local cfg = argcfg or GG.Cfg

    if !file.Exists("gungame/weapons/"..cfg..".txt", "DATA") then       --get and create weap file
        file.Write("gungame/weapons/"..cfg..".txt", "") end

    return util.KeyValuesToTable(file.Read("gungame/weapons/"..cfg..".txt", "DATA"))
end

function WeapFileRead(argcfg)
    local cfg = argcfg or GG.Cfg
    local t = WeapFile(cfg)

    for k, v in pairs(t) do
        print("["..k.."]".." = "..v[1].." ("..v[2]..")")
    end
end

function WeapFileAdd(class, argtype, argcfg)          --append single entries
    local wtype = argtype or "generic"
    local cfg = argcfg or GG.Cfg
    local t = WeapFile(cfg)

    table.insert(t, {class, wtype})
    file.Write("gungame/weapons/"..cfg..".txt", util.TableToKeyValues(t))
end

function WeapFileRemove(class, argcfg)              --remove all entries of class
    local cfg = argcfg or GG.Cfg
    local t = WeapFile(cfg)

    for k, v in pairs(t) do
        if v[1] == class then
            table.remove(t, k)
        end
    end

    file.Write("gungame/weapons/"..cfg..".txt", util.TableToKeyValues(t))
end

function WeapFileType(class, wtype, argcfg)         --Get/set weapon type in file
    local cfg = argcfg or GG.Cfg
    local t = WeapFile(cfg)

    for k, v in pairs(t) do
        if v[1] == class then
            if wtype then v[2] = wtype
            else print(v[2]) end
        end
    end

    file.Write("gungame/weapons/"..cfg..".txt", util.TableToKeyValues(t))
end

function WeapFileClear(cfg)
    file.Delete("gungame/weapons/"..cfg..".txt")
end

function WeapReadFolder(path, mode, argcfg)
    if path && mode then
        local cfg = argcfg or GG.Cfg
        local dir = "gungame/weapons/"..cfg..".txt"

        WeapFile(cfg)

        local f, weps = file.Find(path.."*", "MOD")

        local t = {} 
        if mode == "add" && file.Exists(dir, "DATA") then t = util.KeyValuesToTable(file.Read(dir, "DATA")) end

        for k, v in pairs(weps) do
            table.insert(t, {v, "generic"})         --add weap tables to blank table
        end

        print(util.TableToKeyValues(t))
    
        file.Write(dir, util.TableToKeyValues(t))
    end
end