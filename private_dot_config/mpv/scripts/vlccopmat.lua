-- Copyright (c) 2025, Rubin Bhandari
-- License: MIT License
-- Creator: Rubin Bhandari
-- Project: Vlccompat
-- Version: 1.0.0

--When seeking display position and duration like vlc
mp.register_event("seek", function()
  local pos = mp.get_property_number("time-pos") or 0
  local dur = mp.get_property_number("duration") or 0

  local function format_time(t)
    local h = math.floor(t / 3600)
    local m = math.floor((t % 3600) / 60)
    local s = math.floor(t % 60)
    if h > 0 then
      return string.format("%d:%02d:%02d", h, m, s)
    else
      return string.format("%02d:%02d", m, s)
    end
  end

  local msg = format_time(pos) .. " / " .. format_time(dur)
  mp.osd_message(msg, 2)   -- show for 2 seconds
end)



-- This script creates a simple pause indicator overlay
local ov = mp.create_osd_overlay('ass-events')
ov.data = [[{\an5\p1\alpha&H79\1c&Hffffff&\3a&Hff\pos(760,440)}]] ..
    [[m-125 -75 l 2 2 l -125 75]]

mp.observe_property('pause', 'bool', function(_, paused)
  mp.add_timeout(0.1, function()
    if paused then
      ov:update()
    else
      ov:remove()
    end
  end)
end)
