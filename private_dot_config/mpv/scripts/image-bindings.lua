-- stripped down version of: https://github.com/guidocella/mpv-image-config/blob/main/scripts/image-bindings.lua

mp.register_script_message('cursor-centric-zoom', function(amount)
  local mouse_pos = mp.get_property_native('mouse-pos')
  local dims = mp.get_property_native('osd-dimensions')
  local width = (dims.w - dims.ml - dims.mr) * 2 ^ amount
  local height = (dims.h - dims.mt - dims.mb) * 2 ^ amount
  local command = 'osd-msg add video-zoom ' .. amount .. ';'

  if width > dims.w then
    local old_cursor_ml = dims.ml - mouse_pos.x
    local cursor_ml = old_cursor_ml * 2 ^ amount
    local ml = cursor_ml + mouse_pos.x
    -- from video/out/aspect.c:src_dst_split_scaling() we know that:
    -- ml = (osd-width - width) * (video-align-x + 1) / 2
    -- so video-align-x is:
    local video_align_x = 2 * ml / (dims.w - width) - 1
    command = command .. 'no-osd set video-align-x ' .. math.min(1, math.max(video_align_x, -1)) .. ';'
  end

  if height > dims.h then
    local mt = (dims.mt - mouse_pos.y) * 2 ^ amount + mouse_pos.y
    local video_align_y = 2 * mt / (dims.h - height) - 1
    command = command .. 'no-osd set video-align-y ' .. math.min(1, math.max(video_align_y, -1))
  end

  mp.command(command)
end)
