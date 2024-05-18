-- source is the source of the completion items.
local source = {}

local dbee = require("dbee")
local handler = require("cmp-dbee.handler")
local is_available = dbee.is_core_loaded() and dbee.is_ui_loaded()

--- Constructor for nvim-cmp source
---@param cfg Config
function source:new(cfg)
  local cls = { handler = handler:new(cfg, is_available) }
  setmetatable(cls, self)
  self.__index = self
  return cls
end

function source:complete(_, callback)
  if not self.handler then
    return callback {}
  end

  local items = self.handler:get_completion()
  callback {
    items = items,
    isIncomplete = false,
  }
end

function source:is_available()
  return is_available
end

function source:get_trigger_characters()
  return { '"', "`", "[", "]", ".", "(", ")" }
end

function source:get_debug_name()
  return "cmp-dbee"
end

return source
