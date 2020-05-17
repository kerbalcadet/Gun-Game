AddCSLuaFile("cl_init.lua")

include("config/config.lua")
include("config/filesys.lua")
include("config/commands.lua")
include("weapons.lua")
include("player.lua")
include("mechanics.lua")
include("precache.lua")

GM.Name =  "Gun Game"

function GM:Initialize()
    PreCacheVMs()
    
    if Spawns[1] then SpawnFile(Spawns)
    else Spawns = SpawnFile() end
    
    WeapsAdd()
    
    ended = false
end