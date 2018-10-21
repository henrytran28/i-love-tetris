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

function utils.linearInterpolation(min, max, percent)
    return ((max - min) / 100) * percent + min
end

return utils
