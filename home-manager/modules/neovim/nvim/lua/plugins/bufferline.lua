return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = "VeryLazy",
  enabled = true,
  opts = function ()
    return {
      options = {
        style_preset = require('bufferline').style_preset.minimal,
        indicator = {
          style = 'none',
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = false,
        show_buffer_icons = false,
        separator_style = {"", ""},
      }
    }
  end,
  config = function (_, opts)
    require('bufferline').setup(opts)

    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd("BufAdd", {
      callback = function()
        vim.schedule(function()
          ---@diagnostic disable-next-line: undefined-global
          pcall(nvim_bufferline)
        end)
      end,
    })

    local map = function (key, func, desc)
      vim.keymap.set('n', key, func, { silent = true, desc = 'Bufferline: ' .. desc } )
    end

    map("<S-l>", "<CMD>BufferLineCycleNext<CR>", "Cycle next")
    map("<S-h>", "<CMD>BufferLineCyclePrev<CR>", "Cycle prev")
    map("<leader>x", "<CMD>bdelete<CR>", "Close current buffer")
  end,
}
