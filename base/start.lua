mod_metadata("version", "1.0.0")

local json = require("mods/base/json")

-- helper for dealing with json data
function jet_json_patch(path, callback)
    jet_text_patch(path, function(contents)
        local parsed = json.decode(contents)

        parsed = callback(parsed)

        return json.encode(parsed)
    end)
end

database = require("mods/base/database")
