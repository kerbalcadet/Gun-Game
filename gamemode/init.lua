AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_precache.lua")

include("config/config.lua")
include("config/filesys.lua")
include("config/commands.lua")
include("weapons.lua")
include("player.lua")
include("mechanics.lua")
include("shared.lua")

GM.Name =  "Gun Game"

function GM:Initialize()
    if Spawns[1] then SpawnFile(Spawns)
    else Spawns = SpawnFile() end
    
    WeapsAdd()
    WeapSend()
    WeapPrecache()

    ended = false
end