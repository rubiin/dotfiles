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
    mp.osd_message(msg, 2)  -- show for 2 seconds
end)


-- This script pauses playback when minimizing the window, and resumes playback
-- if it's brought back again. If the player was already paused when minimizing,
-- then try not to mess with the pause state.

local did_minimize = false

mp.observe_property("window-minimized", "bool", function(_, value)
    local pause = mp.get_property_native("pause")
    if value == true then
        if pause == false then
            mp.set_property_native("pause", true)
            did_minimize = true
        end
    elseif value == false then
        if did_minimize and (pause == true) then
            mp.set_property_native("pause", false)
        end
        did_minimize = false
    end
end)
