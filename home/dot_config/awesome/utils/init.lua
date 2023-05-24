local awful = require("awful")
local naughty = require("naughty")
local _utils = {}

function _utils.unMinimizeApplication()
  local c = awful.client.restore()
  -- Focus restored client
  if c then
    c:emit_signal(
        "request::activate", "key.unminimize", { raise = true }
    )
  end
end

function _utils.toggleFullscreen(c)
  c.fullscreen = not c.fullscreen
  c:raise()
end

function _utils.testNotify(msg)
  naughty.notify({text = msg})
end

function _utils.runScript(name)
  scriptPath = "$AWESOME_CONFIG/utils/scripts/"..name
  awful.spawn.with_shell(scriptPath)
end

return _utils