---@class Debug
local Debug = {
    INFO = 1,
    DEBUG = 2,
    WARNING = 3,
    ERROR = 4,
    NONE = 5
}

local logLevel = Debug.NONE

---Parse userdata data type
---@param t userdata | CName | string
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
---@param max? integer --Max number of objects to parse
---@param depth? integer --The depth max to iterate recursively
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
function Debug:Clone(orig, copies)

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
                copy[self:Clone(orig_key, copies)] = self:Clone(orig_value, copies)
            end
            setmetatable(copy, self:Clone(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        copy = orig
    end

    return copy
end

---Parse variables
---@param ... unknown
---@return string
function Debug:Parse(...)
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

---Set log level between INFO, DEBUG, WARNING, ERROR, NONE. Returns itself
---@param level integer
---@return Debug
function Debug:SetLogLevel(level)
    if type(level) == "number" and level >= 1 and level <= 5 then
        logLevel = level
    end

    return self
end

---Log a message to the file. If logLevel <= INFO also logs to the console
---@param msg any
function Debug:Log(msg)
    spdlog.info(string.format('[%s] %s', 'INFO', msg))
    if logLevel <= self.INFO then
        print(string.format('[[[ %s ]]]', msg))
    end
end

---Log INFO messages
---@param msg string
function Debug:Info(msg)
    if logLevel <= self.INFO then
        print(string.format('[[[ %s ]]]', msg))
    end
end

---Log DEBUG messages
---@param msg string
function Debug:Debug(msg)
    if logLevel <= self.DEBUG then
        print(string.format('[[[ %s ]]]', msg))
        spdlog.info(string.format('[%s] %s', 'DEBUG', msg))
    end
end

---Log WARNING messages
---@param msg string
function Debug:Warning(msg)
    if logLevel <= self.WARNING then
        print(string.format('[[[ WARNING: %s ]]]', msg))
        spdlog.warning(string.format('[%s] %s', 'WARNING', msg))
    end
end

---Log ERROR messages
---@param msg string
function Debug:Error(msg)
    if logLevel <= self.ERROR then
        spdlog.error(string.format('[%s] %s', 'ERROR', msg))
        error(msg)
    end
end

---Parse variables and print them into console
---@param ... unknown
function Debug:Dump(...)
    print(self:Parse(...))
end

return Debug
