local utils = require('sapnvim_project.utils')

local M = {}

local function get_default_storage_dir()
  local default_storage_dir
  local ok = pcall(require, 'lazy')
  if ok then
    default_storage_dir = require('lazy.core.config').defaults.root .. '/sapnvim_project.nvim/sessions'
  else
    default_storage_dir = vim.fn.stdpath('config') .. '/sessions'
  end

  if utils.is_valid_path(default_storage_dir) == 0 then
    vim.fn.mkdir(default_storage_dir)
  end

  return default_storage_dir
end

M.defaults = {
  ---type string
  sessions_storage_dir = utils.add_slash_if_folder(get_default_storage_dir()),
  sessions_data_filename = 'sessions_data.lua',
  picker_opts = {
  }
}

M.options = nil

--- Setup function to initialize configuration
---@param user_config table Optional configuration table to override defaults
M.setup = function(user_config)
  -- Initialize with default configuration
  local config = user_config
  local def_opts = M.defaults
  config = vim.tbl_deep_extend("force", {}, def_opts, config or {})

  for key, value in pairs(config) do
    if not M.defaults[key] then -- 直接用键名检查
      error(string.format("%s is not an experience configuration value", key))
    end

    local expected_type = type(M.defaults[key])
    local actual_type = type(config[key])
    if not (expected_type == actual_type) then
      error(string.format(
        "Invalid type for '%s': \nexpected '%s', Default value: %s \ngot '%s', Provided value: %s",
        key,
        expected_type,
        vim.inspect(M.defaults[key]),
        actual_type,
        vim.inspect(value)
      ))
    end
  end

  -- Ensure storage directory ends with slash
  config.sessions_storage_dir = utils.add_slash_if_folder(utils.resolve(config.sessions_storage_dir))

  -- Validate filename
  local ok, msg = utils.is_valid_filename(config.sessions_data_filename, 'lua')
  if not ok and msg then
    msg = string.format('"%s" is Invalid filename, %s', config.sessions_data_filename, msg)
    error(msg)
  end

  -- Store validated options
  M.options = config
end

setmetatable(M, {
  __index = function(_, k)
    if k == "options" then
      return M.defaults
    end
  end,
})

return M
