net.Start("getweaps")
net.SendToServer()

net.Receive("sendweaps", function()
    local t = net.ReadTable()

    for k, v in ipairs(t) do
        print(v[1])
    end
end)