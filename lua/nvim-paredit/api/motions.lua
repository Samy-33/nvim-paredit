local traversal = require("nvim-paredit.utils.traversal")
local ts = require("nvim-treesitter.ts_utils")
local langs = require("nvim-paredit.lang")

local M = {}

function M.move_to_next_element()
  local lang = langs.get_language_api()
  local current_node = lang.get_node_root(ts.get_node_at_cursor())

  local sibling = traversal.get_next_sibling_ignoring_comments(current_node, {
    lang = lang
  })
  if not sibling then
    return
  end

  local pos = { sibling:end_() }
  vim.api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] - 1 })
end

function M.move_to_prev_element()
  local lang = langs.get_language_api()
  local current_node = lang.get_node_root(ts.get_node_at_cursor())

  local sibling = traversal.get_prev_sibling_ignoring_comments(current_node, {
    lang = lang
  })
  if not sibling then
    return
  end

  local pos = { sibling:start() }
  vim.api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
end

return M