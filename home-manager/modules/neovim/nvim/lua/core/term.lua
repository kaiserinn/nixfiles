local M = {}

--- @param cmd string|string[] Command to run (string or list of args)
--- @param opts? { close_on_exit?: boolean, max_height?: number, auto_resize?: boolean } Optional terminal settings
--- - close_on_exit  boolean  Close the terminal window after the command exits (default: false)
--- - max_height     number   Maximum height of the floating window (default: 50% of screen)
--- - auto_resize    boolean  Automatically resize the window to fit content (default: true)
function M.run(cmd, opts)
    opts = opts or {}
    local close_on_exit = opts.close_on_exit or false
    local max_height = opts.max_height or math.floor(vim.o.lines * 0.5)
    local auto_resize = (opts.auto_resize == nil) and true or opts.auto_resize

    local buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].bufhidden = "wipe"

    local min_height = 3
    local win_opts = {
        anchor   = "SW",
        relative = "editor",
        height   = auto_resize and min_height or max_height,
        width    = vim.o.columns - 1,
        row      = vim.o.lines - 1,
        col      = 0,
        style    = "minimal",
        border   = "single",
    }
    local win = vim.api.nvim_open_win(buf, true, win_opts)

    local function close_term()
        if win and vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end

    local function resize_to_content()
        if not (win and vim.api.nvim_win_is_valid(win)) then
            return
        end

        local lines = vim.api.nvim_buf_line_count(buf)
        local height = math.min(math.max(lines + 1, min_height), max_height)
        if height ~= win_opts.height then
            win_opts.height = height
            vim.api.nvim_win_set_config(win, win_opts)
        end
    end

    vim.fn.jobstart(cmd, {
        term = true,
        on_stdout = auto_resize and resize_to_content or nil,
        on_stderr = auto_resize and resize_to_content or nil,
        on_exit = function()
            vim.cmd("stopinsert")
            if auto_resize then
                resize_to_content()
            end
            if close_on_exit then
                close_term()
            end
        end,
    })

    local keymap_opts = { buffer = buf, silent = true, nowait = true }
    vim.keymap.set("n", "<Esc>", close_term, keymap_opts)
    vim.keymap.set("n", "q", close_term, keymap_opts)

    vim.api.nvim_create_autocmd("WinLeave", {
        buffer = buf,
        once = true,
        callback = close_term,
    })

    vim.cmd("startinsert")
end

return M
