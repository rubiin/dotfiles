-- mod-version:3
-- Author: PerilousBooklet (forked from Jipok's nonicons.lua)
-- Doesn't work well with scaling mode == "ui"

local common = require "core.common"
local config = require "core.config"
local style = require "core.style"
local TreeView = require "plugins.treeview"
local Node = require "core.node"

-- Config
config.plugins.devicons = common.merge({
  use_default_dir_icons = false,
  use_default_chevrons = false,
  draw_treeview_icons = true,
  draw_tab_icons = true,
  -- The config specification used by the settings gui
  config_spec = {
    name = "Devicons",
    {
      label = "Use Default Directory Icons",
      description = "When enabled does not use nonicon directory icons.",
      path = "use_default_dir_icons",
      type = "toggle",
      default = false
    },
    {
      label = "Use Default Chevrons",
      description = "When enabled does not use nonicon expand/collapse arrow icons.",
      path = "use_default_chevrons",
      type = "toggle",
      default = false
    },
    {
      label = "Draw Treeview Icons",
      description = "Enables file related icons on the treeview.",
      path = "draw_treeview_icons",
      type = "toggle",
      default = true
    },
    {
      label = "Draw Tab Icons",
      description = "Adds file related icons to tabs.",
      path = "draw_tab_icons",
      type = "toggle",
      default = true
    }
  }
}, config.plugins.devicons)

local icon_font = renderer.font.load(USERDIR.."/fonts/font_devicons/devicons.ttf", 15 * SCALE)
local chevron_width = icon_font:get_width("") -- ?
local previous_scale = SCALE

local extension_icons = {
  [".lua"] = { "#51a0cf", "" },
  [".md"]  = { "#519aba", "" }, -- Markdown
  [".cpp"] = { "#519aba", "" }, -- C++
  [".c"]   = { "#599eff", "" }, [".h"] = { "#599eff", "" },
  [".py"]  = { "#3572A5", "" }, [".pyc"]  = { "#519aba", "" }, [".pyd"]  = { "#519aba", "" }, -- Python
  [".php"] = { "#a074c4", "" },
  [".cs"] = { "#596706", "" },  -- C#
  [".conf"] = { "#6d8086", "" }, [".cfg"] = { "#6d8086", "" },
  [".toml"] = { "#6d8086", "" },
  [".yaml"] = { "#6d8086", "" }, [".yml"] = { "#6d8086", "" },
  [".json"] = { "#854CC7", "" },
  [".css"] = { "#563d7c", "" }, [".module.css"] = { "#563d7c", "" },
  [".sass"] = {"#CF649A", ""}, [".scss"] = {"#CF649A", ""},
  [".html"] = { "#e34c26", "" }, [".html.erb"] = { "#e34c26", "" },
  [".js"] = { "#cbcb41", "" },  -- JavaScript
  [".go"] = { "#519aba", "" },
  [".jpg"] = { "#a074c4", "" }, [".png"] = { "#a074c4", "" }, [".svg"] = { "#a074c4", "" },
  [".sh"] = { "#4d5a5e", "" },  -- Shell
  [".java"] = { "#cc3e44", "" },
  [".scala"] = { "#cc3e44", "" },
  [".kt"] = { "#F88A02", "" }, [".kts"] = { "#F88A02", "" },  -- Kotlin
  [".pl"] = { "#519aba", "" }, [".pm"] = { "#519aba", "" },  -- Perl
  [".r"] = { "#358a5b", "" }, [".R"] = { "#358a5b", "" },
  [".rake"] = { "#701516", "" },
  [".rb"] = { "#701516", "" },  -- Ruby
  [".rs"] = { "#dea584", "" },  -- Rust
  [".rss"] = { "#cc3e44", "" },
  [".sql"] = { "#C84431", "" },
  [".swift"] = { "#e37933", "" },
  [".ts"] = { "#519aba", "" },  -- TypeScript
  [".elm"] = { "#519aba", "" },
  [".diff"] = { "#41535b", "" },
  [".ex"] = { "#a074c4", "" }, [".exs"] = { "#a074c4", "" },  -- Elixir
  [".tex"] = {"#467f22", ""}, [".sty"] = {"#467f22", ""}, [".cls"] = {"#467f22", ""}, [".dtx"] = {"#467f22", ""}, [".ins"] = {"#467f22", ""},
  [".nim"] = { "#FFE953", "" },   [".nims"] = { "#FFE953", "" },   [".nimble"] = { "#FFE953", "" },
  [".zig"] = { "#cbcb41", "" },
  [".jl"] = {"#9359A5", ""}, -- Julia
  [".wasm"] = {"#654EF0", ""}, -- WebAssembly
  [".hs"] = {"#5E5086", ""}, -- Haskell
  [".lsp"] = { "#FFFFFF", "" }, [".lisp"] = { "#FFFFFF", "" },
  [".xml"] = {"#005FAD", ""},
  [".dart"] = {"#055A9C", ""},
  [".clj"] = {"#91DC47", ""}, -- Clojure
  [".asm"] = {"#DE002D", ""}, -- Assembly
  [".nix"] = {"#7EB3DF", ""},
  [".scad"] = {"#e8b829", ""}, -- OpenSCAD
  [".ino"] = {"#008184", ""}, -- Arduino
  --[".j2"] = { "#02D0FF", "" }, -- J
  [".cr"] = { "#000000", "" }, -- Crystal
  [".erl"] = { "#A90533", "" }, [".hrl"] = { "#A90533", "" }, -- Erlang
  [".vala"] = { "#706296", "" },
  [".odin"] = { "#3882D2", "" },
  [".svelte"] = {"#FF3C00", ""},
  [".d"] = {"#B03931", ""}, [".di"] = {"#B03931", ""}, -- D
  [".v"] = {"#536B8A", ""}, -- V .v .vv. vsh
  [".groovy"] = {"#357A93", ""}, -- "%.gvy$", "%.gy$", "%.gsh$"
  -- Following without special icon:
  [".vim"] = { "#8f00ff", "" },
  [".ini"] = { "#ffffff", "" },
  [".fish"] = { "#ca2c92", "" },
  [".bash"] = { "#4169e1", "" },
  [".desktop"] = { "#6d8086", "" },
}

local known_names_icons = {
  ["changelog"] = { "#657175", "" }, ["changelog.txt"] = { "#4d5a5e", "" }, ["changelog.md"] = { "#519aba", "" },
  ["makefile"] = { "#6d8086", "" },
  ["Cmakelists.txt"] = { "#0068C7", "" },
  ["meson.build"] = {"#6d8086", ""}, ["meson_options.txt"] = {"#6d8086", ""}, -- WIP: original icon needs adjustments
  ["dockerfile"] = { "#296478", "" },
  ["docker-compose.yml"] = { "#4289a1", "" },
  ["license"] = { "#d0bf41", "" }, ["license.txt"] = { "#d0bf41", "" },
  ["readme.md"] = { "#72b886", "" }, ["readme"] = { "#72b886", "" },
  ["init.lua"] = { "#2d6496", "" },
  ["setup.py"] = { "#559dd9", "" },
  ["build.zig"] = { "#6d8086", "" },
  ["pkgbuild"] = {"#358fdd", ""}, -- Arch Linux PKGBUILD
  ["gradlew"] = { "#6d8086", "" }, ["gradlew.bat"] = { "#6d8086", "" }, -- Gradle
  -- Web dev framework configuration files
  ["svelte.config.js"] = {"#FF3C00", ""},
  --["postcss.config.js"] = {"#DD3A0A", ""}, [".postcssrc"] = {"#DD3A0A", ""},
  ["tailwind.config.js"] = {"#38BDF8", ""},
  ["alpine.config.js"] = {"#77C1D2", ""},
  --[""] = {"#61DBFB", ""}, -- React
  ["angular.json"] = {"#DE002D", ""},
  ["vue.config.js"] = {"#3FB984", ""},
  ["next.config.js"] = {"#000000", ""},
  ["package.json"] = {"#68A063", ""}, -- Node.js
  [".npmrc"] = {"#CC3534", ""},
  ["babel.config.json"] = {"#F9DC3E", ""}, [".babelrc.json"] = {"#F9DC3E", ""},
  ["schema.prisma"] = { "#2D3748", "" },
  [".tmux.conf"] = { "#1BB91F", "" }, ["tmux.conf"] = { "#1BB91F", "" }
}

-- Preparing colors
for k, v in pairs(extension_icons) do
  v[1] = { common.color(v[1]) }
end
for k, v in pairs(known_names_icons) do
  v[1] = { common.color(v[1]) }
end

-- Override function to change default icons for dirs, special extensions and names
local TreeView_get_item_icon = TreeView.get_item_icon
function TreeView:get_item_icon(item, active, hovered)
  local icon, font, color = TreeView_get_item_icon(self, item, active, hovered)
  if previous_scale ~= SCALE then
    icon_font:set_size(
      icon_font:get_size() * (SCALE / previous_scale)
    )
    chevron_width = icon_font:get_width("") -- ?
    previous_scale = SCALE
  end
  if not config.plugins.devicons.use_default_dir_icons then
    icon = "" -- generic document icon
    font = icon_font
    color = style.text
    if item.type == "dir" then
      icon = item.expanded and "" or "" -- open dir icon, closed dir icon ?
    end
  end
  if config.plugins.devicons.draw_treeview_icons then
    local custom_icon = known_names_icons[item.name:lower()]
    if custom_icon == nil then
      custom_icon = extension_icons[item.name:match("^.+(%..+)$")]
    end
    if custom_icon ~= nil then
      color = custom_icon[1]
      icon = custom_icon[2]
      font = icon_font
    end
    if active or hovered then
      color = style.accent
    end
  end
  return icon, font, color
end

-- Override function to draw chevrons if setting is disabled
local TreeView_draw_item_chevron = TreeView.draw_item_chevron
function TreeView:draw_item_chevron(item, active, hovered, x, y, w, h)
  if not config.plugins.devicons.use_default_chevrons then
    if item.type == "dir" then
      local chevron_icon = item.expanded and "" or ""  -- open arrow icon, closed arrow icon ?
      local chevron_color = hovered and style.accent or style.text
      common.draw_text(icon_font, chevron_color, chevron_icon, nil, x, y, 0, h)
    end
    return chevron_width + style.padding.x/4
  end
  return TreeView_draw_item_chevron(self, item, active, hovered, x, y, w, h)
end

-- Override function to draw icons in tabs titles if setting is enabled
local Node_draw_tab_title = Node.draw_tab_title
function Node:draw_tab_title(view, font, is_active, is_hovered, x, y, w, h)
  if config.plugins.devicons.draw_tab_icons then
    local padx = chevron_width + style.padding.x/2
    local tx = x + padx -- Space for icon
    w = w - padx
    Node_draw_tab_title(self, view, font, is_active, is_hovered, tx, y, w, h)
    if (view == nil) or (view.doc == nil) then return end
    local item = { type = "file", name = view.doc:get_name() }
    TreeView:draw_item_icon(item, false, is_hovered, x, y, w, h)
  else
    Node_draw_tab_title(self, view, font, is_active, is_hovered, x, y, w, h)
  end
end
