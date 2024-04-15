-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Set up the auto command to run the function when Neovim starts
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function ()
      local args = vim.fn.argv()
      local num_args = #args

      if num_args == 2 or num_args == 3 then
        vim.cmd('edit ' .. args[1])  -- Open the first file normally
        for i = 2, num_args do
          vim.cmd('vsplit ' .. args[i])  -- Open subsequent files in vertical splits
        end
      end
    end,
})
