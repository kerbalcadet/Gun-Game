GG = {}
Spawns = {}

ammo = {
    ["pistol"] = 5,
    ["smg"] = 8,
    ["shotgun"] = 3,
    ["semiauto"] = 5,
    ["assault"] = 6,
    ["lmg"] = 5,
    ["sniper"] = 3,
    ["explosive"] = 1,
    ["generic"] = 5,
    ["launcher"] = 1,
    ["noammo"] = 0
}

GG.Knife = "weapon_crowbar"

pms = {
    "models/player/phoenix.mdl",
    "models/player/gman_high.mdl",
    "models/player/corpse1.mdl",
    "models/player/hostage/hostage_01.mdl",
    "models/player/hostage/hostage_04.mdl",
    "models/player/gasmask.mdl",
    "models/player/guerilla.mdl"
}


    --convars / properties--


GG.Health = CreateConVar("gg_health", 50, "FCVAR_NONE", "", 1)
GG.Falldmg = CreateConVar("gg_falldmg", 0, "FCVAR_NONE", "", 0)
GG.Barrier = CreateConVar("gg_barrier", 0, "FCVAR_NONE", "", -1, 1)
GG.Barrierheight = CreateConVar("gg_barrierheight", 0, "FCVAR_NONE", "")
GG.Spawndist = CreateConVar("gg_spawndist", 800, "FCVAR_NONE", "", 0)
GG.Weapnum = CreateConVar("gg_weapnum", 15, "FCVAR_NONE", "", 1, 100)
GG.Cfg = "ins2"
GG.Lastwep = "cw_kk_ins2_nade_c4"