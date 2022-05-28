local awful = require("awful")

return {
    -- Toggle titlebar on or off depending on s. Creates titlebar if it doesn't exist
    setTitlebar = function(client, s)
        if s then
            if client.titlebar == nil then
                client:emit_signal("request::titlebars", "rules", {})
            end
            awful.titlebar.show(client)
        else
            awful.titlebar.hide(client)
        end
    end
}