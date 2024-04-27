local Utils = require("Utils")
local GameHUD = require("GameHUD")
local Cron = require("Cron")
local GameSettings = {}

function GameSettings.ApplyGameStatus(effect)
    Game.GetStatusEffectSystem():ApplyStatusEffect(GetPlayer():GetEntityID(), effect, GetPlayer():GetRecordID(), GetPlayer():GetEntityID())
end

function GameSettings.RemoveGameStatus(effect)
    Game.GetStatusEffectSystem():RemoveStatusEffect(GetPlayer():GetEntityID(), effect)
end

function GameSettings.Get(category, name)
    if string.find(category, '/') == 1 then
        return Game.GetSettingsSystem():GetVar(category, name):GetValue()
    else
        return GameOptions.Get(category, name)
    end
end

function GameSettings.GetIndex(category, name)
    if string.find(category, '/') == 1 then
        return Game.GetSettingsSystem():GetVar(category, name):GetIndex()
    end
end

function GameSettings.Set(category, name, value)
    if string.find(category, '/') == 1 then
        if type(value) == 'number' then
            Game.GetSettingsSystem():GetVar(category, name):SetIndex(value)
        else
            Game.GetSettingsSystem():GetVar(category, name):SetValue(value)
        end
    else
        GameOptions.Set(category, name, value)
    end
end

function GameSettings.SetAll(settings)
    for k, v in next, settings do
        GameSettings.Set(v.category, v.name, v.value)
    end
end

function GameSettings.RefreshGame(timeout)
    Utils.DebugMessage("Refreshing the game")
    GameHUD.ShowMessage("REFRESHING")
    GameSettings.ApplyGameStatus("GameplayRestriction.NoZooming")
    GameSettings.ApplyGameStatus("GameplayRestriction.NoMovement")
    GameSettings.SetTimeDilation(0.0)
    Cron.After(timeout, function()
        GameSettings.RemoveGameStatus("GameplayRestriction.NoZooming")
        GameSettings.RemoveGameStatus("GameplayRestriction.NoMovement")
        GameSettings.UnsetTimeDilation()
        GameHUD.ShowMessage("REFRESH Done")
        Utils.DebugMessage("Refreshing done")
    end)
end

function GameSettings.SetTimeDilation(time)
    Game.GetTimeSystem():SetTimeDilation("RefreshPause", time)
end

function GameSettings.UnsetTimeDilation()
    Game.GetTimeSystem():UnsetTimeDilation("RefreshPause")
end

function GameSettings.IsRaining()
    return Game.GetWeatherSystem():GetRainIntensity() > 0 and true or false
end

function GameSettings.IsIndoors()
    return IsEntityInInteriorArea(GetPlayer())
end

function GameSettings.HasDLSSD()
    return Game.GetSettingsSystem():GetVar("/graphics/presets", "DLSS_D"):GetValue()
end

function GameSettings.HasPathTracing()
    return GameSettings.Get("/graphics/raytracing", "RayTracedPathTracing")
end

return GameSettings

