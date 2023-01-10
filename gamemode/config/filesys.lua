


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

function InitWeaponFiles()
    for i, wep in ipairs(weapons.GetList()) do
        local cat, cn = wep.Category, wep.ClassName

        if cat && cat:find("^ARC9*") then cat = "arc9" end

        local types = {
            ["Grenade"] = "explosive",
            ["Assault Rifle"] = "assault",
            ["Pistol"] = "pistol",
            ["Shotgun"] = "shotgun",
            ["Submachine Gun"] = "smg",
            ["Antimateriel Rifle"] = "sniper",
            ["Light Machine Gun"] = "lmg",
            ["General-Purpose Machine Gun"] = "lmg",
            ["Sniper Rifle"] = "sniper",
            ["Machine Pistol"] = "smg",
            ["Bladed Weapon"] = "noammo",
            ["Bolt-Action Rifle"] = "sniper",
            ["Battle Rifle"] = "assault",
            ["Melee"] = "noammo",
            ["Grenade Launcher"] = "launcher",
            ["Dedicated Marksman Rifle"] = "semiauto",
            ["Squad Assault Weapon"] = "lmg",
            ["Self-Loading Rifle"] = "semiauto",
        }
        local wtype = types[wep.Class] or "generic"

        if (not WeapFile(cat).cn) and wep.Spawnable then
            WeapFileAdd(cn, wtype, cat)
        end
    end
end

function WeapFile(argcfg)
    local cfg = argcfg or CFG

    if !file.Exists("gungame/weapons/"..cfg..".txt", "DATA") then       --get and create weap file
        file.Write("gungame/weapons/"..cfg..".txt", "") end

    return util.KeyValuesToTable(file.Read("gungame/weapons/"..cfg..".txt", "DATA"))
end

function WeapFileRead(argcfg)
    local cfg = argcfg or CFG
    local t = WeapFile(cfg)

    for k, v in pairs(t) do
        print("["..k.."]".." = "..v[1].." ("..v[2]..")")
    end
end

function WeapFileAdd(class, argtype, argcfg)          --append single entries
    local wtype = argtype or "generic"
    local cfg = argcfg or CFG
    local t = WeapFile(cfg)

    table.insert(t, {class, wtype})
    file.Write("gungame/weapons/"..cfg..".txt", util.TableToKeyValues(t))
end

function WeapFileRemove(key, argcfg)              --remove all entries of class
    local cfg = argcfg or CFG
    local t = WeapFile(cfg)
    local tn = {}

    for k, v in pairs(t) do
        if !string.find(v[1], key) && k != tonumber(key) and v[2] != key then
            table.insert(tn, v)                   --lua doesn't like removing indexes while iterating; new table it is
        end
    end

    file.Write("gungame/weapons/"..cfg..".txt", util.TableToKeyValues(tn))
    print(WeapFileRead(cfg))
end

function WeapFileType(key, wtype, argcfg)         --Get/set weapon type in file
    local cfg = argcfg or CFG
    local t = WeapFile(cfg)

    for k, v in pairs(t) do
        if string.find(v[1], key) or k == tonumber(key) or v[2] == key then
            if wtype then v[2] = wtype
            else print(v[2]) end
        end
    end

    file.Write("gungame/weapons/"..cfg..".txt", util.TableToKeyValues(t))
    if wtype then print(WeapFileRead(cfg)) end
end

function WeapFileClear(cfg)
    file.Delete("gungame/weapons/"..cfg..".txt")
end



    --model file--



function ModelFile(argcfg)
    local cfg = argcfg or CFG

    if !file.IsDir("gungame/models/", "DATA") then
        file.CreateDir("gungame/models/", "DATA") end

    if !file.Exists("gungame/models/"..cfg..".txt", "DATA") then       --get and create model file
        file.Write("gungame/models/"..cfg..".txt", "") end

    return util.KeyValuesToTable(file.Read("gungame/models/"..cfg..".txt", "DATA"))
end

function ModelFileRead(argcfg)
    local cfg = argcfg or CFG
    local t = ModelFile(cfg)

    for k, v in pairs(t) do
        print("["..k.."] = "..v)
    end
end

function ModelFileClear(cfg)
    file.Delete("gungame/models/"..cfg..".txt")
end

function ModelReadFolder(path, mode, argcfg)
    if path && mode then
        local cfg = argcfg or CFG
        local dir = "gungame/models/"..cfg..".txt"

        ModelFile(cfg)

        local files, m = file.Find(path.."*.mdl", "MOD")

        local t = {} 
        if mode == "add" && file.Exists(dir, "DATA") then t = util.KeyValuesToTable(file.Read(dir, "DATA"))
        elseif mode != "write" then return end

        for k, v in pairs(files) do
            local str = "models/weapons/"..v
            table.insert(t, str)         --add weap tables to blank table
        end
    
        file.Write(dir, util.TableToKeyValues(t))

        print(ModelFileRead(cfg))
    end
end