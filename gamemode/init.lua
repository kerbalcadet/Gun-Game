AddCSLuaFile("cl_init.lua")
include("config/config.lua")
include("config/filesys.lua")
include("config/commands.lua")
include("config/weapons.lua")
include("player.lua")
include("mechanics.lua")


GM.Name =  "Gun Game"

function GM:Initialize()
    if Spawns[1] then SpawnFile(Spawns)
    else Spawns = SpawnFile() end
    WeapsAdd("ins2")
end

--spawning mechanics
