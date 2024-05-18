Utils = {}

function Utils.DebugMessage(msg)
	if settings.debug then
		print('[[[ ', msg ,' ]]]')
	end
end

function Utils.Clone(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[Utils.Clone(orig_key, copies)] = Utils.Clone(orig_value, copies)
            end
            setmetatable(copy, Utils.Clone(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local function dump(o)
	local typeO = type(o)
	if typeO == 'table' then
		local export = {}
		for k, v in pairs(o) do
			table.insert(export, string.format("%s: %s", k, dump(v)))
		end
		return '{ ' .. table.concat(export, ', ') .. ' }'
	elseif typeO == 'boolean' or typeO == 'number' or typeO == 'nil' then
		return tostring(o)
	else
		return '"' .. tostring(o) .. '"'
	end
end

function Utils.Dump(o)
	print(dump(o))
end

return Utils
