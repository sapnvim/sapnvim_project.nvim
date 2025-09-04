local M = {}

function M.create_mommands()
  vim.api.nvim_create_user_command('ProjectLoad', function()
    require('sapnvim_project.project').project_preselector()
  end, {})
  vim.api.nvim_create_user_command('ProjectSave', function()
    require('sapnvim_project.project').save_project()
  end, {})
  vim.api.nvim_create_user_command('ProjectAdd', function()
    require('sapnvim_project.project').create_project()
  end, {})
  vim.api.nvim_create_user_command('ProjectClose', function()
    require('sapnvim_project.project').close_project()
  end, {})
  vim.api.nvim_create_user_command('ProjectToggle', function()
    require('sapnvim_project.project').toggle_between_projects()
  end, {})
end

return M
