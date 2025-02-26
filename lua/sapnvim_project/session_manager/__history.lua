--- history.lua

local storage = require('sapnvim_project.session_manager.__storage')

local history = {}

local history_table = {}

--- load_history_from_file
--- Load historical data from the data file and update the local history_table.
---@return { name: string, path: string }[] history_table Returns the history table.
local function load_history_form_file()
  local data = storage.load_data_form_file()
  if data.history then
    history_table = data.history
  else
    history_table = {}
  end
  return history_table
end

local function is_duplicate_session(history_session)
  if not history_session then
    error("Valid parameters must be passed in!")
  end
  local last_entry = history_table[#history_table]
  if last_entry and history_session.path == last_entry.path then
    return true
  end
  return false
end

local function keep_only_two()
  if #history_table > 2 then
    table.remove(history_table, 1)
  end
end

--- get_history_sessions
--- Get all stored history records.
--- Load the latest data from the data file before each call.
---@return { name: string, path: string }[] history_table Return the history table.
function history.get_history_sessions()
  return load_history_form_file()
end

function history.create_history_session(history_session, save)
  save = save or false
  local data = storage.load_data_form_file()

  if not is_duplicate_session(history_session) then
    table.insert(history_table, history_session)
  end
  keep_only_two()

  data.history = history_table
  storage.write_data_to_file(data)
  if save then
    history_session.name = storage.get_sessions_storage_dir() .. '../' .. history_session.name
    vim.cmd(string.format('silent! mks! %s', history_session.name))
  end
end

return history
