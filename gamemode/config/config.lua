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

KNIFE = "weapon_crowbar"

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


HEALTH = CreateConVar("gg_health", 50, "FCVAR_NONE", "", 1)
FALL_DMG = CreateConVar("gg_falldmg", 0, "FCVAR_NONE", "", 0)
BARRIER = CreateConVar("gg_barrier", 0, "FCVAR_NONE", "", -1, 1)
BARRIER_HEIGHT = CreateConVar("gg_barrier_height", 0, "FCVAR_NONE", "")
SPAWN_DIST = CreateConVar("gg_spawn_dist", 800, "FCVAR_NONE", "", 0)
WEAP_NUM = CreateConVar("gg_weap_num", 15, "FCVAR_NONE", "", 1, 100)
TYPE_TABLE_RAND = CreateConVar("gg_type_table_rand", 0, "FCVAR_NONE", "", 0, 1)
WEAP_TABLE_RAND = CreateConVar("gg_weap_table_rand", 0, "FCVAR_NONE", "", 0, 1)
CFG = "ins2"