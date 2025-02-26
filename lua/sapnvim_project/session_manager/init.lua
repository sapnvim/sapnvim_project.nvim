local sessions = require('sapnvim_project.session_manager.__sessions')
local history = require('sapnvim_project.session_manager.__history')

local session_manager = {}

--- get_all_sessions
--- Retrieves all stored session records.
---
--- Loads the sessions from the sessions data file and returns the sessions table.
---
---@return { name: string, path: string }[] sessions_table A table containing session records, where each record is a table with keys:
---@type fun(): { name: string, path: string }[]
session_manager.get_all_sessions = sessions.get_all_sessions

--- add_session
--- Add a new session to sessions_table and save it to the data file.
--- At the same time, call the Vim command to generate a session file.
---@param new_session { name: string, path: string } New session information, should contain at least { name = string, path = string }.
---@return boolean Returns true if added successfully, otherwise returns false.
---@type fun(new_session: { name: string, path: string }): boolean
session_manager.create_session = sessions.add_session

--- save_existing_session
--- Save the existing session and regenerate the session file.
---@param old_session { name: string, path: string } indicates the session record to be saved.
---@return boolean boolean # Returns true if the save is successful, otherwise returns false.
---@type fun(old_session: { name: string, path: string }): boolean
session_manager.save_existing_session = sessions.save_existing_sessin

--- load_session
--- Loads a session.
--- Closes all buffers, checks the session path using utils.is_valid_path,
--- and sources the session file from config.defaults.sessions_storage_dir.
---@param selected_session table { value: string, name: string }
---@return boolean true if loaded, false otherwise.
---@type fun(selected_session: { value: string, name: string }): boolean
session_manager.load_session = sessions.load_session

session_manager.close_session = sessions.close_session

--- get_history_sessions
--- Get all stored history records.
--- Load the latest data from the data file before each call.
--- @return { name: string, path: string }[] history_table Return the history table.
---@type fun(): { name: string, path: string }[]
session_manager.get_history_sessions = history.get_history_sessions

session_manager.create_history_session = history.create_history_session

return session_manager
