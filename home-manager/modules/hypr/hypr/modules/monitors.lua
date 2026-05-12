local monitors = { "eDP-1", "eDP-2" }

for _, monitor in ipairs(monitors) do
    hl.monitor({
        output   = monitor,
        mode     = "preferred",
        position = "auto",
        scale    = "1.25",
    })
end

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- mirror
-- hl.monitor({ output="", mode="1920x1080", position="auto", scale="1" })
-- hl.monitor({ output="", mode="preferred", position="auto", scale="1" })
