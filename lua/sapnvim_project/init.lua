local config = require('sapnvim_project.config')
local M = {}

function M.setup(user_opts)
  config.setup(user_opts)
  require('sapnvim_project.autocmds').create_aotucmd()
end

function M.register_cmd()
  require('sapnvim_project.commands').create_mommands()
end

return M
