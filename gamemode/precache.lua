function PreCacheVMs()
    for k, v in pairs(WeapFile())
    do
        util.PrecacheModel(string.gsub(WeapFile()[k][1], "cw_kk_ins2", "v"))
    end
end