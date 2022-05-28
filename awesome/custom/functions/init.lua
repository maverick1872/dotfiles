function unMinimizeApplication()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
        c:emit_signal(
                "request::activate", "key.unminimize", {raise = true}
        )
    end
end

function toggleFullscreen(c)
    c.fullscreen = not c.fullscreen
    c:raise()
end

return {
    unMinimizeApplication,
    toggleFullscreen
}