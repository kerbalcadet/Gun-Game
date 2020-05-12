AddCSLuaFile("cl_init.lua")
include("config.lua")
include("filesys.lua")
include("player.lua")
include("commands.lua")
include("mechanics.lua")


GM.Name =  "Gun Game"

function GM:Initialize()
    if Spawns[1] then SpawnFile(Spawns)
    else Spawns = SpawnFile() end
    print("test")
end

--spawning mechanics
