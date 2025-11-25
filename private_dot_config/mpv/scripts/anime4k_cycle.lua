-- anime4k_cycle.lua
-- Place this in ~/.config/mpv/scripts/

-- List of shader chains
local shader_modes = {
  {
    name = "Anime4K: Mode A (Fast)",
    shaders = {
      "~~/shaders/Anime4K_Clamp_Highlights.glsl",
      "~~/shaders/Anime4K_Restore_CNN_M.glsl",
      "~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl",
      "~~/shaders/Anime4K_AutoDownscalePre_x2.glsl",
      "~~/shaders/Anime4K_AutoDownscalePre_x4.glsl",
      "~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl",
    },
  },
  {
    name = "Anime4K: Mode B (Fast)",
    shaders = {
      "~~/shaders/Anime4K_Clamp_Highlights.glsl",
      "~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl",
      "~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl",
      "~~/shaders/Anime4K_AutoDownscalePre_x2.glsl",
      "~~/shaders/Anime4K_AutoDownscalePre_x4.glsl",
      "~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl",
    },
  },
  {
    name = "Anime4K: Mode C (Fast)",
    shaders = {
      "~~/shaders/Anime4K_Clamp_Highlights.glsl",
      "~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_M.glsl",
      "~~/shaders/Anime4K_AutoDownscalePre_x2.glsl",
      "~~/shaders/Anime4K_AutoDownscalePre_x4.glsl",
      "~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl",
    },
  },
  {
    name = "Anime4K: Mode A+A (Fast)",
    shaders = {
      "~~/shaders/Anime4K_Clamp_Highlights.glsl",
      "~~/shaders/Anime4K_Restore_CNN_M.glsl",
      "~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl",
      "~~/shaders/Anime4K_Restore_CNN_S.glsl",
      "~~/shaders/Anime4K_AutoDownscalePre_x2.glsl",
      "~~/shaders/Anime4K_AutoDownscalePre_x4.glsl",
      "~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl",
    },
  },
  {
    name = "Anime4K: Mode B+B (Fast)",
    shaders = {
      "~~/shaders/Anime4K_Clamp_Highlights.glsl",
      "~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl",
      "~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl",
      "~~/shaders/Anime4K_AutoDownscalePre_x2.glsl",
      "~~/shaders/Anime4K_AutoDownscalePre_x4.glsl",
      "~~/shaders/Anime4K_Restore_CNN_Soft_S.glsl",
      "~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl",
    },
  },
  {
    name = "Anime4K: Mode C+A (Fast)",
    shaders = {
      "~~/shaders/Anime4K_Clamp_Highlights.glsl",
      "~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_M.glsl",
      "~~/shaders/Anime4K_AutoDownscalePre_x2.glsl",
      "~~/shaders/Anime4K_AutoDownscalePre_x4.glsl",
      "~~/shaders/Anime4K_Restore_CNN_S.glsl",
      "~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl",
    },
  },
}

-- Current mode index
local current_mode = 1

-- Function to apply shaders
local function apply_mode(mode)
  local shader_chain = table.concat(mode.shaders, ";")
  mp.commandv("no-osd", "change-list", "glsl-shaders", "set", shader_chain)
  mp.osd_message(mode.name)
end

-- Cycle function
local function cycle_shaders()
  current_mode = current_mode + 1
  if current_mode > #shader_modes then
    current_mode = 1
  end
  apply_mode(shader_modes[current_mode])
end

-- Keybinding
mp.add_key_binding("CTRL+c", "cycle-anime4k", cycle_shaders)
