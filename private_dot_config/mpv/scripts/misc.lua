

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
