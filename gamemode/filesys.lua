function SpawnFile(tbl)
    local dir = "gungame/"..game.GetMap()..".txt"


    if !file.Exists(dir, "DATA") then 
        file.CreateDir("gungame")
        file.Write(dir, "")
    end

    if tbl then
        file.Write(dir, "")

        for k, v in pairs(tbl) do
            local str = v.x..","..v.y..","..v.z..","
            file.Append(dir, str)
        end
    end

    if(str) then file.Write(dir, str) end
    
    return file.Read(dir, "DATA")
end
