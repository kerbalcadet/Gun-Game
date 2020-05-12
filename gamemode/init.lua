AddCSLuaFile("cl_init.lua")
include("config.lua")
include("filesys.lua")
include("functions.lua")
include("player.lua")


GM.Name =  "Gun Game"

function GM:Initialize()
    if Spawns[1] then SpawnFile(Spawns)
    else Spawns = SpawnFile() end
end

--spawning mechanics

function GM:PlayerInitialSpawn(ply)
    initplayer(ply)     --player.lua
end

function GM:PlayerSpawn(ply)
    setupplayer(ply)    --player.lua
end

function GM:PlayerDeath(vic, inf, att)
    handledeath(vic, inf, att)
end

