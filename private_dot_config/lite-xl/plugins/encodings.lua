--mod-version:3 --priority:5
local core = require "core"
local common = require "core.common"
local command = require "core.command"
local style = require "core.style"
local Doc = require "core.doc"
local DocView = require "core.docview"
local CommandView = require "core.commandview"
local StatusView = require "core.statusview"

---@type encoding
local encoding = require "libraries.encoding"

local encodings = {}

---@class encodings.encoding
---@field charset string
---@field name string

---List of encoding regions.
---@type table<integer,string>
encodings.groups = {
  "West European",
  "East European",
  "East Asian",
  "SE & SW Asian",
  "Middle Eastern",
  "Unicode"
}

---Supported iconv encodings grouped by region.
---@type table<integer,encodings.encoding[]>
encodings.list = {
  -- West European
  {
    { charset = "ISO-8859-14",  name = "Celtic"         },
    { charset = "ISO-8859-7",   name = "Greek"          },
    { charset = "WINDOWS-1253", name = "Greek"          },
    { charset = "ISO-8859-10",  name = "Nordic"         },
    { charset = "ISO-8859-3",   name = "South European" },
    { charset = "IBM850",       name = "Western"        },
    { charset = "ISO-8859-1",   name = "Western"        },
    { charset = "ISO-8859-15",  name = "Western"        },
    { charset = "WINDOWS-1252", name = "Western"        }
  },
  -- East European
  {
    { charset = "ISO-8859-4",   name = "Baltic"             },
    { charset = "ISO-8859-13",  name = "Baltic"             },
    { charset = "WINDOWS-1257", name = "Baltic"             },
    { charset = "IBM852",       name = "Central European"   },
    { charset = "ISO-8859-2",   name = "Central European"   },
    { charset = "WINDOWS-1250", name = "Central European"   },
    { charset = "IBM855",       name = "Cyrillic"           },
    { charset = "ISO-8859-5",   name = "Cyrillic"           },
    { charset = "ISO-IR-111",   name = "Cyrillic"           },
    { charset = "KOI8-R",       name = "Cyrillic"           },
    { charset = "WINDOWS-1251", name = "Cyrillic"           },
    { charset = "CP866",        name = "Cyrillic/Russian"   },
    { charset = "KOI8-U",       name = "Cyrillic/Ukrainian" },
    { charset = "ISO-8859-16",  name = "Romanian"           }
  },
  -- East Asian
  {
    { charset = "GB18030",     name = "Chinese Simplified" },
    { charset = "GB2312",      name = "Chinese Simplified" },
    { charset = "GBK",         name = "Chinese Simplified" },
    { charset = "HZ",          name = "Chinese Simplified" },
    { charset = "BIG5",        name = "Chinese Traditional" },
    { charset = "BIG5-HKSCS",  name = "Chinese Traditional" },
    { charset = "EUC-TW",      name = "Chinese Traditional" },
    { charset = "EUC-JP",      name = "Japanese" },
    { charset = "ISO-2022-JP", name = "Japanese" },
    { charset = "SHIFT_JIS",   name = "Japanese" },
    { charset = "CP932",       name = "Japanese" },
    { charset = "EUC-KR",      name = "Korean" },
    { charset = "ISO-2022-KR", name = "Korean" },
    { charset = "JOHAB",       name = "Korean" },
    { charset = "UHC",         name = "Korean" }
  },
  -- SE & SW Asian
  {
    { charset = "ARMSCII-8",        name = "Armenian"   },
    { charset = "GEORGIAN-ACADEMY", name = "Georgian"   },
    { charset = "TIS-620",          name = "Thai"       },
    { charset = "IBM857",           name = "Turkish"    },
    { charset = "WINDOWS-1254",     name = "Turkish"    },
    { charset = "ISO-8859-9",       name = "Turkish"    },
    { charset = "TCVN",             name = "Vietnamese" },
    { charset = "VISCII",           name = "Vietnamese" },
    { charset = "WINDOWS-1258",     name = "Vietnamese" }
  },
  -- Middle Eastern
  {
    { charset = "IBM864",       name = "Arabic"        },
    { charset = "ISO-8859-6",   name = "Arabic"        },
    { charset = "WINDOWS-1256", name = "Arabic"        },
    { charset = "IBM862",       name = "Hebrew"        },
    { charset = "ISO-8859-8-I", name = "Hebrew"        },
    { charset = "WINDOWS-1255", name = "Hebrew"        },
    { charset = "ISO-8859-8",   name = "Hebrew Visual" }
  },
  -- Unicode
  {
    { charset = "UTF-7",    name = "Unicode" },
    { charset = "UTF-8",    name = "Unicode" },
    { charset = "UTF-16LE", name = "Unicode" },
    { charset = "UTF-16BE", name = "Unicode" },
    { charset = "UCS-2LE",  name = "Unicode" },
    { charset = "UCS-2BE",  name = "Unicode" },
    { charset = "UTF-32LE", name = "Unicode" },
    { charset = "UTF-32BE", name = "Unicode" }
  }
};

---Get the list of encodings associated to a region.
---@param label string
---@return encodings.encoding[] | nil
function encodings.get_group(label)
  for idx, name in ipairs(encodings.groups) do
    if name == label then
      return encodings.list[idx]
    end
  end
end

---Get the list of encodings associated to a region.
---@return encodings.encoding[] | nil
function encodings.get_all()
  local all = {}
  for idx, _ in ipairs(encodings.groups) do
      for _, item in ipairs(encodings.list[idx]) do
        table.insert(all, item)
      end
  end
  return all
end

---Open a commandview to select a charset and executes the given callback,
---@param title_label string Title displayed on the commandview
---@param callback fun(charset: string)
function encodings.select_encoding(title_label, callback)
  core.command_view:enter(title_label, {
    submit = function(_, item)
      callback(item.charset)
    end,
    suggest = function(text)
      local charsets = encodings.get_all()
      local list_labels = {}
      local list_charset = {}
      for _, element in ipairs(charsets) do
        local label = element.name .. " (" .. element.charset .. ")"
        table.insert(list_labels, label)
        list_charset[label] = element.charset
      end
      local res = common.fuzzy_match(list_labels, text)
      for i, name in ipairs(res) do
        res[i] = {
          text = name,
          charset = list_charset[name]
        }
      end
      return res
    end
  })
end

--------------------------------------------------------------------------------
-- Overwrite Doc methods to properly add encoding detection and conversion.
--------------------------------------------------------------------------------
function Doc:new(filename, abs_filename, new_file)
  self.new_file = new_file
  self.encoding = nil
  self.convert = false
  self:reset()
  if filename then
    self:set_filename(filename, abs_filename)
    if not new_file then
      self:load(filename)
    end
  end
end

function Doc:load(filename)
  if not self.encoding then
    local errmsg
    self.encoding, errmsg = encoding.detect(filename);
    if not self.encoding then core.error("%s", errmsg) error(errmsg) end
  end
  self.convert = false
  if self.encoding ~= "UTF-8" and self.encoding ~= "ASCII" then
    self.convert = true
  end
  local fp = assert( io.open(filename, "rb") )
  self:reset()
  self.lines = {}
  local i = 1
  if self.convert then
    local content = fp:read("*a");
    content = assert(encoding.convert("UTF-8", self.encoding, content, {
      strict = false,
      handle_from_bom = true
    }))
    for line in content:gmatch("([^\n]*)\n?") do
      if line:byte(-1) == 13 then
        line = line:sub(1, -2)
        self.crlf = true
      end
      table.insert(self.lines, line .. "\n")
      self.highlighter.lines[i] = false
      i = i + 1
    end
    content = nil
  else
    for line in fp:lines() do
      if (i == 1) then line = encoding.strip_bom(line, "UTF-8") end
      if line:byte(-1) == 13 then
        line = line:sub(1, -2)
        self.crlf = true
      end
      table.insert(self.lines, line .. "\n")
      self.highlighter.lines[i] = false
      i = i + 1
    end
  end
  if #self.lines == 0 then
    table.insert(self.lines, "\n")
  end
  fp:close()
  self:reset_syntax()
end

function Doc:save(filename, abs_filename)
  if not filename then
    assert(self.filename, "no filename set to default to")
    filename = self.filename
    abs_filename = self.abs_filename
  else
    assert(self.filename or abs_filename, "calling save on unnamed doc without absolute path")
  end
  local fp
  local output = ""
  if not self.convert then
    fp = assert( io.open(filename, "wb") )
    for _, line in ipairs(self.lines) do
      if self.crlf then line = line:gsub("\n", "\r\n") end
      fp:write(line)
    end
  else
      output = table.concat(self.lines);
      if self.crlf then output = output:gsub("\n", "\r\n") end
  end
  local conversion_error = false
  if self.convert then
    local errmsg
    output, errmsg = encoding.convert(self.encoding, "UTF-8", output, {
      strict = true,
      handle_to_bom = true
    })
    if output then
      fp = assert( io.open(filename, "wb") )
      fp:write(encoding.get_charset_bom(self.encoding) .. output)
      fp:close()
    else
      conversion_error = true
      core.error("%s", errmsg)
    end
  else
    fp:close()
  end
  self:set_filename(filename, abs_filename)
  if not conversion_error then
    self.new_file = false
  else
    self.new_file = true
  end
  self:clean()
end

--------------------------------------------------------------------------------
-- Register command to change current document encoding.
--------------------------------------------------------------------------------
command.add("core.docview", {
  ["doc:change-encoding"] = function(dv)
    encodings.select_encoding("Select Output Encoding", function(charset)
      dv.doc.encoding = charset
      if charset ~= "UTF-8" and charset ~= "ASCII" then
        dv.doc.convert = true
      else
        dv.doc.convert = false
      end
      dv.doc:save()
    end)
  end,

  ["doc:reload-with-encoding"] = function(dv)
    encodings.select_encoding("Reload With Encoding", function(charset)
      dv.doc.encoding = charset
      if charset ~= "UTF-8" and charset ~= "ASCII" then
        dv.doc.convert = true
      else
        dv.doc.convert = false
      end
      dv.doc:reload()
    end)
  end
})

--------------------------------------------------------------------------------
-- Register a statusbar item to view change current doc encoding.
--------------------------------------------------------------------------------
core.status_view:add_item({
  predicate = function()
    return  core.active_view:is(DocView)
      and not core.active_view:is(CommandView)
  end,
  name = "doc:encoding",
  alignment = StatusView.Item.RIGHT,
  get_item = function()
    local dv = core.active_view
    return {
      style.text, dv.doc.encoding or "none"
    }
  end,
  command = function(button)
    if button == "left" then
      command.perform "doc:change-encoding"
    elseif button == "right" then
      command.perform "doc:reload-with-encoding"
    end
  end,
  tooltip = "encoding"
})


return encodings;
