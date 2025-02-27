---sessions.lua

local utils = require('sapnvim_project.utils')
local storage = require('sapnvim_project.session_manager.__storage')
local sessions_storage_dir = storage.get_sessions_storage_dir()

local sessions = {}

local sessions_table = {}

--- load_sessions_from_file
--- Loads session data from the file specified by sessions_data_file.
---
--- Uses pcall with dofile to safely execute and load the content of the file.
--- If successful and the loaded result is a table containing a "sessions" field,
--- then sessions_table is updated accordingly. Otherwise, sessions_table is reset to an empty table.
---
---@return { name: string, path: string }[] sessions_table A table containing session records, where each record is a table with keys:
---        - name (string): the session name.
---        - path (string): the session path.
local function load_sessions_form_file()
  local data = storage.load_data_form_file()
  if data.sessions then
    sessions_table = data.sessions
  else
    sessions_table = {}
  end
  return sessions_table
end

--- session_exists_in_cache
--- Checks if a session already exists in the sessions_table based on the provided path.
---
--- Iterates through sessions_table to find a session whose "path" field matches the provided path.
---
---@param session { name: string, path: string }? The path used to check against existing sessions.
---@return { name: string, path: string }? s Returns the matching session table if found, otherwise nil.
local function session_exists_is_cache(session)
  if not session then
    return nil
  end
  for _, s in ipairs(sessions_table) do
    if s.path == session.path then
      return s
    end
  end
  return nil
end

--- get_all_sessions
--- Retrieves all stored session records.
---
--- Loads the sessions from the sessions data file and returns the sessions table.
---
---@return { name: string, path: string }[] sessions_table A table containing session records, where each record is a table with keys:
function sessions.get_all_sessions()
  return load_sessions_form_file()
end

--- add_session
--- Add a new session to sessions_table and save it to the data file.
--- At the same time, call the Vim command to generate a session file.
---@param new_session { name: string, path: string } New session information, should contain at least { name = string, path = string }.
---@return boolean Returns true if added successfully, otherwise returns false.
function sessions.add_session(new_session)
  if not new_session then
    return false
  end
  table.insert(sessions_table, new_session)
  local data = storage.load_data_form_file()
  data.sessions = sessions_table
  storage.write_data_to_file(data)
  new_session.name = sessions_storage_dir .. new_session.name
  vim.cmd(string.format('silent! mks! %s', new_session.name))
  return true
end

--- save_existing_session
--- Save the existing session and regenerate the session file.
---@param old_session { name: string, path: string }? indicates the session record to be saved.
---@return boolean boolean # Returns true if the save is successful, otherwise returns false.
function sessions.save_existing_sessin(old_session)
  local existing = session_exists_is_cache(old_session)
  -- vim.notify(vim.inspect(existing))
  -- vim.notify(vim.inspect(sessions_table))
  if not existing then
    return false
  end
  existing.name = sessions_storage_dir .. existing.name
  vim.cmd(string.format('silent! mks! %s', existing.name))
  return true
end

--- load_session
--- Loads a session.
--- Closes all buffers, checks the session path using utils.is_valid_path,
--- and sources the session file from config.defaults.sessions_storage_dir.
---@param selected_session { value: string, name: string }? table
---@return boolean # if loaded, false otherwise.
function sessions.load_session(selected_session)
  if not selected_session then
    return false
  end

  -- Cache session values for clarity.
  local session_path = selected_session.value
  local session_name = selected_session.name

  -- Validate the provided session path.
  if not utils.is_valid_path(session_path) == 1 or not selected_session then
    return false
  end
  -- Construct the full path to the session file and source it.
  local session_file = sessions_storage_dir .. session_name
  vim.cmd(string.format("silent! source %s", session_file))
  return true
end

function sessions.close_session(selected_session, change)
  change = change or false
  if not selected_session then
    return false
  end
  vim.cmd('silent %bd')
  if not change then
    vim.cmd.cd(vim.env.PWD)
  end
  return true
end

return sessions
