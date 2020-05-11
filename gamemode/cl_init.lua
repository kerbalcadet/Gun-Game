net.Receive("death", function()
    vic = net.ReadEntity()
    inf = net.ReadEntity()
    att = net.ReadEntity()

    if att:IsPlayer() && vic:IsPlayer() then
        GAMEMODE:AddDeathNotice("test", "test", "test", "test", "test")
    end
end)