local M = {}

local g = require("modules.globals")

function M.bind_exec(bind, cmd)
    hl.bind(bind, hl.dsp.exec_cmd(cmd))
end

function M.bindm_exec(bind, cmd)
    hl.bind(g.mainMod .. " + " .. bind, hl.dsp.exec_cmd(cmd))
end

function M.bindm(bind, dispatcher)
    hl.bind(g.mainMod .. " + " .. bind, dispatcher)
end

return M
