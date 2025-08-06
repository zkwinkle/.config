local M = {}

M.load_mapping = function(mapping, extra_opts)
  for mode, mode_keys in pairs(mapping) do
    for keybind, mapping_info in pairs(mode_keys) do
      if mode == "all" then
        mode = ""
      end

      local opts = {}
      if mapping_info.opts then
        opts = mapping_info.opts
      end
      if extra_opts then
        opts = vim.tbl_deep_extend("keep", opts, extra_opts)
      end

      vim.keymap.set(mode, keybind, mapping_info.map, opts)
    end
  end
end


M.mapping_to_lazy_keys = function(mapping, extra_opts)
  local lazy_keys = {}

  for mode, mode_keys in pairs(mapping) do
    for keybind, mapping_info in pairs(mode_keys) do
      if mode == "all" then
        mode = ""
      end

      local opts = {}
      if mapping_info.opts then
        opts = mapping_info.opts
      end
      if extra_opts then
        opts = vim.tbl_deep_extend("keep", opts, extra_opts)
      end

      local lazy_key = { keybind, mapping_info.map, mode = mode, ft = mapping_info.ft }
      lazy_key = vim.tbl_deep_extend("keep", lazy_key, opts)

      table.insert(lazy_keys, lazy_key)

      vim.keymap.set(mode, keybind, mapping_info.map, opts)
    end
  end

  return lazy_keys
end

M.cmix = function(x, factor)
  if not x or factor == 0 then
    return x
  end

  local r = math.floor(x / 2 ^ 16)
  local x1 = x - (r * 2 ^ 16)
  local g = math.floor(x1 / 2 ^ 8)
  local b = math.floor(x1 - (g * 2 ^ 8))

  local function mix(c, target, f)
    return math.floor(c + (target - c) * f)
  end

  -- If positive, lighten by mixing with 255 (white)
  -- If negative, darken by mixing with 0 (black)
  local target = factor > 0 and 255 or 0
  factor = math.abs(factor)

  r = mix(r, target, factor)
  g = mix(g, target, factor)
  b = mix(b, target, factor)

  return math.floor(r * 2 ^ 16 + g * 2 ^ 8 + b)
end

return M
