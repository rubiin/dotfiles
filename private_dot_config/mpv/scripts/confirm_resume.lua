--[[
MPV Confirm Resume Script
Author: Rubin Bhandari + ChatGPT
Configurable via script-opts/confirm_resume.conf
Supports:
- auto_resume (true/false)
- save_interval (seconds)
]]

local utils = require("mp.utils")
local options = require("mp.options")

-- =======================
-- Default Options
-- =======================
local o = {
  resume_text = "⏪ Resume at %ds? (Y/N) ❓",
  wait_interval = 5,
  max_entries = 200,
  auto_resume = false,   -- automatically resume without asking
  save_interval = 3      -- seconds to debounce saving
}

-- Load user options
options.read_options(o)

print("Confirm Resume Script Loaded", o.auto_resume)

-- =======================
-- Variables
-- =======================
-- Use MPV data directory for runtime files
data_dir = os.getenv("XDG_DATA_HOME") or os.getenv("HOME") .. "/.local/share"
data_dir = data_dir .. "/mpv"
local resume_file = data_dir .. "/resume.json"
local resume_data = {}
local save_timer = nil
local resume_pending = nil
local resume_dirty = false

----------------------------------------------------------------------
-- Ensure resume.json exists
----------------------------------------------------------------------
local function ensure_resume_file()
  local dir = resume_file:match("(.+)/[^/]+$")
  os.execute(string.format('mkdir -p "%s"', dir))
  local f = io.open(resume_file, "r")
  if not f then
    f = io.open(resume_file, "w")
    if f then
      f:write("{}")
      f:close()
    end
  else
    f:close()
  end
end

----------------------------------------------------------------------
-- Load resume data once
----------------------------------------------------------------------
local function load_resume()
  if next(resume_data) ~= nil then return end
  ensure_resume_file()
  local f = io.open(resume_file, "r")
  if not f then return end
  local text = f:read("*a")
  f:close()
  local data = utils.parse_json(text)
  if type(data) == "table" then
    resume_data = data
  end
end

----------------------------------------------------------------------
-- Atomic save
----------------------------------------------------------------------
local function save_resume()
  if not resume_dirty then return end
  ensure_resume_file()
  local tmp = resume_file .. ".tmp"
  local f = io.open(tmp, "w")
  if f then
    f:write(utils.format_json(resume_data))
    f:close()
    os.rename(tmp, resume_file)
    resume_dirty = false
  end
end

----------------------------------------------------------------------
-- Debounced save (controlled by save_interval)
----------------------------------------------------------------------
local function schedule_save()
  resume_dirty = true
  if save_timer then
    save_timer:kill()
  end
  save_timer = mp.add_timeout(o.save_interval, function()
    save_resume()
    save_timer = nil
  end)
end

----------------------------------------------------------------------
-- Trim resume_data to max_entries
----------------------------------------------------------------------
local function trim_resume_data()
  local count = 0
  local paths = {}
  for path in pairs(resume_data) do
    count = count + 1
    table.insert(paths, path)
  end
  if count <= o.max_entries then return end
  while count > o.max_entries do
    local path_to_remove = table.remove(paths, 1)
    resume_data[path_to_remove] = nil
    count = count - 1
  end
end

----------------------------------------------------------------------
-- Prompt user to resume
----------------------------------------------------------------------
local function prompt_resume(path, pos)
  if o.auto_resume then
    mp.set_property_number("time-pos", pos)
    mp.osd_message(string.format("⏪ Resumed at %ds", math.floor(pos)))
    return
  end

  resume_pending = { path = path, pos = pos }
  mp.osd_message(string.format(o.resume_text, math.floor(pos)), o.wait_interval)
  mp.add_timeout(o.wait_interval * 60, function()
    if resume_pending then
      mp.osd_message("▶ Starting from beginning")
      resume_pending = nil
    end
  end)
end

----------------------------------------------------------------------
-- Key bindings
----------------------------------------------------------------------
local function do_resume()
  if resume_pending then
    mp.set_property_number("time-pos", resume_pending.pos)
    mp.osd_message(string.format("⏪ Resumed at %ds", math.floor(resume_pending.pos)))
    resume_pending = nil
  end
end

local function skip_resume()
  if resume_pending then
    mp.osd_message("▶ Starting from beginning")
    resume_pending = nil
  end
end

mp.add_forced_key_binding("y", "resume-yes", do_resume)
mp.add_forced_key_binding("Y", "resume-yes-upper", do_resume)
mp.add_forced_key_binding("n", "resume-no", skip_resume)
mp.add_forced_key_binding("N", "resume-no-upper", skip_resume)

----------------------------------------------------------------------
-- File loaded event
----------------------------------------------------------------------
mp.register_event("file-loaded", function()
  load_resume()
  local path = mp.get_property("path")
  if path and not path:match("^https?://") and resume_data[path] then
    prompt_resume(path, resume_data[path])
  end
end)

----------------------------------------------------------------------
-- Track playback position
----------------------------------------------------------------------
mp.observe_property("time-pos", "number", function(_, pos)
  local path = mp.get_property("path")
  if path and pos and not path:match("^https?://") then
    resume_data[path] = pos
    trim_resume_data()
    schedule_save()
  end
end)

----------------------------------------------------------------------
-- Save on exit
----------------------------------------------------------------------
mp.register_event("shutdown", save_resume)
