local Debug = {
    enable = false
}

---Parse userdata data type
---@param t userdata|CName|string
---@return any
local function parseUserData(t)
    local tstr = tostring(t)

    if tstr:find('^ToCName{') then
        tstr = NameToString(t)
    elseif tstr:find('^userdata:') or tstr:find('^sol%.') then
        local gdump = false
        local ddump = false
        pcall(function() gdump = GameDump(t) end)
        pcall(function() ddump = Dump(t, true) end)

        if gdump then
            tstr = GameDump(t)
        elseif ddump then
            tstr = ddump
        end
    end

    return tstr
end

---Parse objects deeply
---@param t any --The object
---@param max integer --Max number of objects to parse
---@param depth integer --The depth max to iterate recursively
---@return string
local function parseDeep(t, max, depth)

    if type(t) ~= 'table' then

        if type(t) == 'userdata' then
            t = parseUserData(t)
        end

        return t
    end

    max = max or 63
    depth = depth or 4
    local dumpStr = '{\n'
    local indent = string.rep(' ', depth)

    for k, v in pairs(t) do
        -- vars
        local ktype = type(k)
        local vtype = type(v)
        local vstr = ''

        -- key
        local kstr = ''
        if ktype == 'string' then
            kstr = string.format('[%q] = ', k)
        end

        -- string
        if vtype == 'string' then
            vstr = string.format('%q', v)

        -- table
        elseif vtype == 'table' then

            if depth < max then
                vstr = parseDeep(v, max, depth + 4)
            end

        -- userdata
        elseif vtype == 'userdata' then
            vstr = parseUserData(v)

        -- thread (do nothing)
        elseif vtype == 'thread' then

        -- else
        else
            vstr = tostring(v)
        end

        -- format dump
        if vstr ~= '' then
            dumpStr = string.format('%s%s%s%s,\n', dumpStr, indent, kstr, vstr)
        end
    end

    -- unindent
    local unIndent = indent:sub(1, -5)

    return string.format('%s%s}', dumpStr, unIndent)
end

---Clone objects
---@param orig any
---@param copies any
---@return any
function Debug.Clone(orig, copies)

    local orig_type = type(orig)
    local copy
    copies = copies or {}

    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[Debug.Clone(orig_key, copies)] = Debug.Clone(orig_value, copies)
            end
            setmetatable(copy, Debug.Clone(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        copy = orig
    end

    return copy
end

---Parse variables
---@param ... unknown
---@return string
function Debug.Parse(...)
    local args = {}
    local output = ""

    for _, v in pairs{...} do
        table.insert(args, parseDeep(v))
    end

    for i, value in pairs(args) do
        output = output .. tostring(value)
        if i ~= #args then
            output = output .. " "
        end
    end

    return output
end

---Log message into mod log file and console
---@param msg string
function Debug.Log(msg)
    Debug.Info(msg)
    spdlog.info(string.format(' [%s] %s', 'INFO', msg))
end

---Print any message with info format if debug is enabled
---@param msg string
function Debug.Info(msg)
	if Debug.enable then
        print(string.format('[[[ %s ]]]', msg))
	end
end

---Parse variables and print them into console
---@param ... unknown
function Debug.Dump(...)
    print(Debug.Parse(...))
end

return Debug
