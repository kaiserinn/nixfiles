return {
  dir = "~/dev/jjui.nvim",
  config = function()
    vim.keymap.set("n", "<leader>jj", "<cmd>JJUI<cr>", {
      desc = "JJUI: Open JJUI",
    })
  end
}
