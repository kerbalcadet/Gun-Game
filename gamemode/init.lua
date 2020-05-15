AddCSLuaFile("cl_init.lua")
AddCSLuaFile("debug.lua")

include("config/config.lua")
include("config/filesys.lua")
include("config/commands.lua")
include("weapons.lua")
include("player.lua")
include("mechanics.lua")
include("debug.lua")


GM.Name =  "Gun Game"

function GM:Initialize()
    if Spawns[1] then SpawnFile(Spawns)
    else Spawns = SpawnFile() end
    WeapsAdd(GG.Cfg)
    ended = false
end