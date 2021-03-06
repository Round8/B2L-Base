local csv = require("mods/base/csv")

-- metadata about the base mod
if current_mod_path == "mods/base" or current_mod_path == "mods\\base" then
    mod_metadata("name", "Base Mod")
    mod_metadata("version", "1.2.0")
    mod_metadata("author", "the B2L team")
end

-- helper for dealing with csv data
function jet_csv_patch(path, callback)
    jet_text_patch(path, function(contents)
        local parsed = csv.decode(contents)
        parsed = callback(parsed)
        return csv.encode(parsed)
    end)
end

-- helper for dealing with json data
function jet_json_patch(path, callback)
    jet_text_patch(path, function(contents)
        local parsed = rapidjson.decode(contents)

        parsed = callback(parsed)

        return rapidjson.encode(parsed)
    end)
end

function jet_json_advanced_patch(path, callback)
    jet_text_patch(path, function(contents)
        local document = rapidjson.Document()

        local ok, err = document:parse(contents)
        if not ok then
            error(err)
        end

        callback(document)

        return document:stringify()
    end)
end

-- database of file paths
database = require("mods/base/database")
