local session_manager = require('sapnvim_project.session_manager')
local utils = require('sapnvim_project.utils')
local config = require('sapnvim_project.config')

local options = config.options
local autocmd = vim.api.nvim_create_autocmd

local function create_aotucmd()
  autocmd({ 'VimLeavePre' }, {
    callback = function()
      if not (vim.v.dying == 0) then
        return
      end

      local name = vim.fn.fnamemodify(utils.resolve(utils.cwd()), ':t')
      local cwd = utils.add_slash_if_folder(utils.resolve(utils.cwd()))
      local session = { name = name, path = cwd }
      if session_manager.save_existing_session(session) then
        session_manager.create_history_session(session)
      else
        session.name = 'tmp'
        session_manager.create_history_session(session, true)
      end
    end
  })

  -- Autocommands for automatic session recovery
  if options and options.auto_session_restore ~= 'none' and vim.fn.argc() == 0 then
    autocmd({ 'VimEnter' }, {
      callback = function()
        -- Make sure this is only executed when the VimEnter event is triggered
        if vim.v.vim_did_enter == 0 then
          return
        end

        -- Use vim.defer_fn to delay session loading to ensure other plugins are initialized
        vim.defer_fn(function()
          -- If configured to load the last exited session
          if options.auto_session_restore == "last" then
            -- Get history sessions and load the last session
            local history_sessions = session_manager.get_history_sessions()
            if #history_sessions > 0 then
              session_manager.load_history_session()
            end
            return
          end

          -- If configured to load the session of the current directory
          if options.auto_session_restore == "current" then
            local name = vim.fn.fnamemodify(utils.resolve(utils.cwd()), ':t')
            local cwd = utils.add_slash_if_folder(utils.resolve(utils.cwd()))
            local session = { name = name, path = cwd }

            session_manager.get_all_sessions()
            local existing = session_manager.session_exists_is_cache(session)

            if not existing then
              return
            end

            vim.notify("Loading project session: " .. existing.name, vim.log.levels.INFO)
            session_manager.load_session(existing)
          end
        end, 500) -- Delay execution by 500 milliseconds
      end
    })
  end
end

return { create_aotucmd = create_aotucmd }
