weaps = {}

if SERVER then
    
function GetRandomWeap(weap_type)
    local t = WeapFile()

    repeat
        tmp_weap =t[math.random(#t)]
    until tmp_weap[2] ==weap_type and tmp_weap[2] !="disabled"

    return tmp_weap
end

function WeapsAdd()
    weaps ={}

    if !file.Exists("gungame/weapons/"..CFG..".txt", "DATA") then return end
    
    local types = {
    "pistol",
    "shotgun",
    "smg",
    "semiauto",
    "generic",
    "assault",
    "lmg",
    "sniper",
    "explosive",
    "launcher"
    }
    local weap_num =WEAP_NUM:GetInt()
    local grp_num_per =math.ceil(weap_num/10)
    local grp_num =(weap_num-(weap_num%10))/grp_num_per

    for weap_type =1, 10, 1
    do
        if(weap_type <=grp_num) then
            for weap =1, grp_num_per, 1
            do
                cur_weap =GetRandomWeap(types[weap_type])
                table.insert(weaps, {class =cur_weap[1], type =cur_weap[2]})
            end
        else
            cur_weap =GetRandomWeap(types[weap_type])
            table.insert(weaps, {class =cur_weap[1], type =cur_weap[2]})
        end
    end
end

function WeapValid(str)
    local ply = player.GetAll()[1]
    if !ply then
        print("error: need valid player")
        return
    end

    if ply:Give(str, true) != NULL then 
        ply:StripWeapon(str)
        return true
    elseif ply:GetWeapon(str):IsValid() then
        return true
    else
        print("invalid weapon!")
        return false
    end
end

end