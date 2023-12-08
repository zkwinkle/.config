local M = {}

M.load_mapping = function(mapping, extra_opts)
	for mode, mode_values in pairs(mapping) do
		if mode == "opt" then goto continue end
		for keybind, mapping_info in pairs(mode_values) do
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
		::continue::
	end
end

function M.open(path)
  vim.validate({
    path = { path, 'string' },
  })
  local is_uri = path:match('%w+:')
  if not is_uri then
    path = vim.fn.expand(path)
  end

  local cmd

  if vim.fn.has('mac') == 1 then
    cmd = { 'open', path }
  elseif vim.fn.has('win32') == 1 then
    cmd = { 'explorer', path }
  elseif vim.fn.executable('wslview') == 1 then
    cmd = { 'wslview', path }
  elseif vim.fn.executable('xdg-open') == 1 then
    cmd = { 'xdg-open', path }
  else
    return nil, 'vim.ui.open: no handler found (tried: wslview, xdg-open)'
  end

	local ret = vim.fn.jobstart(cmd, { detach = true })
  if ret <= 0 then
    local msg = {
      "Failed to open uri",
      ret,
      vim.inspect(cmd),
    }
    vim.notify(table.concat(msg, "\n"), vim.log.levels.ERROR)
  end

	return nil, ret
end

function M.get_visual_selection()
  local save_a = vim.fn.getreginfo('a')
  vim.cmd([[norm! "ay]])
  local selection = vim.fn.getreg('a', 1)
  vim.fn.setreg('a', save_a)
  return selection
end

return M
