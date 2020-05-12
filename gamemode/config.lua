weaps = {
    Knife = "weapon_crowbar",
    ammo = {
        ["pistol"] = 5,
        ["smg"] = 5,
        ["shotgun"] = 1,
        ["semiauto"] = 4,
        ["assault"] = 6,
        ["lmg"] = 5,
        ["sniper"] = 1,
        ["explosive"] = 1 },

    [1] = {weap = "cw_kk_ins2_doi_webley", type = "pistol"},
    [2] = {weap = "cw_kk_ins2_m1911", type = "pistol"},
    [3] = {weap = "cw_kk_ins2_mp5k", type = "smg"},
    [4] = {weap = "cw_kk_ins2_aks74u", type = "smg"},
    [5] = {weap = "cw_kk_ins2_sks", type = "semiauto"},
    [6] = {weap = "cw_kk_ins2_ak74", type = "assault"},
    [7] = {weap = "cw_kk_ins2_m4a1", type = "assault"},
    [8] = {weap = "cw_kk_ins2_fnfal", type = "semiauto"},
    [9] = {weap = "cw_kk_ins2_rpk", type = "lmg"},
    [10] = {weap = "cw_kk_ins2_m40a1", type = "sniper"},
    [11] = {weap = "weapon_frag", type = "explosive"}
}



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
GG.Falldmg = CreateConVar("gg_noclip", 0, "FCVAR_NONE", "", 0)

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