local csv = {}

function csv.decode(contents)
    local csv = {}
    for line in string.gmatch(contents, '([^\r\n]+)') do
        local fields = {}
        for x in string.gmatch(line, '([^,]+)') do
            fields[#fields + 1] = x
        end
        
        table.insert(csv, fields)
    end
    return csv
end

function csv.encode(data)
    out = ""
    for i = 1, #data do
        for j = 1, #data[i] do
            if j > 1 then 
                out = out .. ',' 
            end
            out = out .. data[i][j]
        end
        out = out .. '\n'
    end
    return out
end

return csv
