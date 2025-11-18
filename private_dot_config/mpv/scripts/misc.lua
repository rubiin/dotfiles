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


-- -- 🕓 Auto-skip intros shorter than 60 seconds (if chapters exist)
-- mp.register_event("file-loaded", function()
--     local chapters = mp.get_property_native("chapter-list")
--     if chapters and #chapters > 0 then
--         local first = chapters[1]
--         if first.time < 60 then
--             mp.commandv("seek", first.time + 10, "absolute", "exact")
--             mp.osd_message("Skipped intro to " .. first.time + 10 .. "s")
--         end
--     end
-- end)


-- 🧠 8. Auto-load subtitles in same folder

-- Useful when filenames don’t match exactly.

mp.register_event("file-loaded", function()
    local path = mp.get_property("path")
    if not path then return end
    local dir = string.match(path, "(.+)/[^/]+$")
    local files = io.popen('ls "' .. dir .. '"'):lines()
    for f in files do
        if f:match("%.srt$") or f:match("%.ass$") then
            mp.commandv("sub-add", dir .. "/" .. f)
        end
    end
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



-- This script makes mpv disable ontop when pausing and re-enable it again when resuming playback
--please note that this won't do anything if ontop was not enabled before pausing

local was_ontop = false

mp.observe_property("pause", "bool", function(_, value)
    local ontop = mp.get_property_native("ontop")
    if value then
        if ontop then
            mp.set_property_native("ontop", false)
            was_ontop = true
        end
    else
        if was_ontop and not ontop then
            mp.set_property_native("ontop", true)
        end
        was_ontop = false
    end
end)
