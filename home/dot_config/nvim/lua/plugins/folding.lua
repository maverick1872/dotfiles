-- Custom fold text handler for ufo showing line count folded
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0

  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end

  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {
      fold_virt_text_handler = handler,
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    },
    config = function(_, opts)
      local ufo = require('ufo')
      ufo.setup(opts)

      vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })
      vim.keymap.set('n', 'K', function()
        local winid = ufo.peekFoldedLinesUnderCursor(true)
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { desc = 'LSP: Show hover documentation and folded code' })
    end,
  },
}
