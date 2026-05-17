local g = require("modules.globals")
local u = require("modules.utils")

u.bindm_exec("T", g.term)
u.bindm_exec("M", "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
u.bindm_exec("E", "kitty -e " .. g.fileManager)
u.bind_exec("ALT + B", "rofi -show drun -show-icons")
u.bind_exec("ALT + SPACE", "nc -U /run/user/1000/walker/walker.sock")
u.bindm("Q", hl.dsp.window.close())
u.bindm("Q", hl.dsp.window.close())
u.bindm("F", hl.dsp.window.float({ action = "toggle" }))
u.bindm("P", hl.dsp.window.pseudo())
u.bindm("J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + hjkl
u.bindm("H", hl.dsp.focus({ direction = "left" }))
u.bindm("L", hl.dsp.focus({ direction = "right" }))
u.bindm("K", hl.dsp.focus({ direction = "up" }))
u.bindm("J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    u.bindm(key, hl.dsp.focus({ workspace = i }))
    u.bindm("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
u.bindm("S", hl.dsp.workspace.toggle_special("magic"))
u.bindm("SHIFT + L", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
u.bindm("mouse_down", hl.dsp.focus({ workspace = "e+1" }))
u.bindm("mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(g.mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(g.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

u.bindm("SHIFT + A", hl.dsp.workspace.move({ monitor = "l" }))
u.bindm("SHIFT + D", hl.dsp.workspace.move({ monitor = "r" }))

-- Laptop multimedia keys for volume and LCD brightness
local volumeUpCmd =
"pamixer -i 2 && notify-send -t 3000 -i audio-volume-high -r 9999 \"$(pamixer --get-volume)%\" -h int:value:$(pamixer --get-volume)"
local volumeDownCmd =
"pamixer -d 2 && notify-send -t 1000 -i audio-volume-low -r 9999 \"$(pamixer --get-volume)%\" -h int:value:$(pamixer --get-volume)"

hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(volumeUpCmd),
    { locked = true, repeating = true })
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd(volumeDownCmd),
    { locked = true, repeating = true })
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("pamixer -t"),
    { locked = true, repeating = true }
)
-- hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
--     { locked = true, repeating = true })

hl.bind(
    "ALT + Up",
    hl.dsp.exec_cmd(volumeUpCmd),
    { locked = true, repeating = true, separate = true }
)
hl.bind(
    "ALT + Down",
    hl.dsp.exec_cmd(volumeDownCmd),
    { locked = true, repeating = true }
)

local brightnessDevices = { "amdgpu_bl1", "amdgpu_bl2" }
for _, device in ipairs(brightnessDevices) do
    local brightnessUpCmd = "brightnessctl -m -d " ..
    device ..
    " s +5% | awk -F, '{system(\"notify-send -t 1000 -i brightness-high -r 9999 \" $4 \" -h int:value:\" int($4))}'"
    local brightnessDownCmd = "brightnessctl -m -d " ..
    device ..
    " s 5%- | awk -F, '{system(\"notify-send -t 1000 -i brightness-high -r 9999 \" $4 \" -h int:value:\" int($4))}'"

    hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(brightnessUpCmd), { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(brightnessDownCmd), { locked = true, repeating = true })
    hl.bind("ALT + Right", hl.dsp.exec_cmd(brightnessUpCmd), { locked = true, repeating = true })
    hl.bind("ALT + Left", hl.dsp.exec_cmd(brightnessDownCmd), { locked = true, repeating = true })
end

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshot
u.bind_exec(
    "Print",
    "grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name') - | wl-copy && notify-send \"Screenshot taken\""
)
u.bindm_exec("SHIFT + S", "grim -g \"$(slurp -d)\" - | wl-copy && notify-send \"Screenshot taken\"")
u.bindm_exec("SHIFT + X", "grim -t ppm -g \"$(slurp -d -c '##ff0000ff')\" - | satty --fullscreen -f -")

-- Clipboard
u.bindm_exec("V", "cliphist list | rofi -dmenu | cliphist decode | wl-copy")
