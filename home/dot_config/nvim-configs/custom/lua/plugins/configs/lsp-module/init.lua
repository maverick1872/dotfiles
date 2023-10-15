local autoGrp = vim.api.nvim_create_augroup
local autoCmd = vim.api.nvim_create_autocmd

local M = {}

M.globalOnAttach = function(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local group = autoGrp('LSPDocumentHighlight', {})

    vim.opt.updatetime = 1000

    autoCmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      group = group,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    autoCmd({ 'CursorMoved' }, {
      buffer = bufnr,
      group = group,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
end

return M
