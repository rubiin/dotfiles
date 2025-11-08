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

