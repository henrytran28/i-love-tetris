local utils = {}

function utils.shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function utils.getKeyFromValue(table, value)
    for k, v in pairs(table) do
        if type(v) == "table" then
            for _, v in pairs(v) do
                if v == value then return k end
            end
        else
            if v == value then return k end
        end
    end
end

return utils
