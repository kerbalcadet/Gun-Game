pms = {
    "models/player/phoenix.mdl",
    "models/player/gman_high.mdl",
    "models/player/corpse1.mdl",
    "models/player/hostage/hostage_01.mdl",
    "models/player/hostage/hostage_04.mdl",
    "models/player/gasmask.mdl",
    "models/player/guerilla.mdl"
}

GG = {}
GG.Health = CreateConVar("gg_health", 20, "FCVAR_NONE", "", 1)
GG.AmmoGain = CreateConVar("gg_ammogain", 1, "FCVAR_NONE", "", 0)
GG.Noclip = CreateConVar("gg_noclip", 0, "FCVAR_NONE", "", 0, 1)
GG.Falldmg = CreateConVar("gg_falldmg", 0, "FCVAR_NONE", "", 0)
GG.Barrier = CreateConVar("gg_barrier", 0, "FCVAR_NONE", "", -1, 1)
GG.Barrierheight = CreateConVar("gg_barrierheight", 0, "FCVAR_NONE", "")
GG.Spawndist = CreateConVar("gg_spawndist", 800, "FCVAR_NONE", "", 0)
GG.Weapnum = CreateConVar("gg_weapnum", 10, "FCVAR_NONE", "", 0)
GG.Cfg = "ins2"
GG.Lastwep = "cw_kk_ins2_nade_c4"

function GM:PlayerNoClip()
    return GG.Noclip:GetInt() > 0
end

function GM:GetFallDamage(ply, speed)
    return GG.Falldmg
end

function GM:SetPlayerSpeed()
    return 500
end

Spawns = {}