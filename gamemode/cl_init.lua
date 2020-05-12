net.Receive("death", function()
    vic = net.ReadEntity()
    inf = net.ReadEntity()
    att = net.ReadEntity()

    if att == LocalPlayer() then
        if(att == vic) then chat.AddText(Color(255, 255, 255), "you died ")
        else chat.AddText(Color(255, 255, 255), "killed "..vic:GetName()) end
    end
end)