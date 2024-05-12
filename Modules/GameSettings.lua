local Utils = require("Modules/Utils")
local GameHUD = require("Modules/GameHUD")
local GameUI = require("Modules/GameUI")
local Cron = require("Modules/Cron")
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

function GameSettings.SetIndex(category, name, index)
    if string.find(category, '/') == 1 and type(index) == 'number' then
        Game.GetSettingsSystem():GetVar(category, name):SetIndex(index)
    end
end

function GameSettings.Set(category, name, value)
    if string.find(category, '/') == 1 then
        Game.GetSettingsSystem():GetVar(category, name):SetValue(value)
    else
        GameOptions.Set(category, name, value)
    end
end

function GameSettings.SetAll(settings)
    for k, v in next, settings do
        GameSettings.Set(v.category, v.name, v.value)
    end
end

function GameSettings.CanTimeSkip()
    local player = GetPlayer()

    return player and GameTimeUtils.CanPlayerTimeSkip(player)
end

function GameSettings.CanRefresh()
    return not GameUI.IsScene() and not Game.GetTimeSystem():IsTimeDilationActive()
end

function GameSettings.RefreshGame(timeout)
    local x = GameSettings.Get('/controls/fppcameramouse', 'FPP_MouseX')
    local y = GameSettings.Get('/controls/fppcameramouse', 'FPP_MouseY')

    Utils.DebugMessage("Refreshing the game")
    GameHUD.ShowMessage("REFRESHING")

    --Camera Movement
    GameSettings.Set('/controls/fppcameramouse', 'FPP_MouseX', 0)
    GameSettings.Set('/controls/fppcameramouse', 'FPP_MouseY', 0)

    --Player Movement
    GameSettings.ApplyGameStatus("GameplayRestriction.NoZooming")
    GameSettings.ApplyGameStatus("GameplayRestriction.NoMovement")
    GameSettings.ApplyGameStatus("GameplayRestriction.NoCombat")
    GameSettings.SetTimeDilation(0.0)
    Cron.After(timeout, function()
        GameSettings.Set('/controls/fppcameramouse', 'FPP_MouseX', x)
        GameSettings.Set('/controls/fppcameramouse', 'FPP_MouseY', y)
        GameSettings.RemoveGameStatus("GameplayRestriction.NoZooming")
        GameSettings.RemoveGameStatus("GameplayRestriction.NoMovement")
        GameSettings.RemoveGameStatus("GameplayRestriction.NoCombat")
        GameSettings.UnsetTimeDilation()
        GameHUD.ShowMessage("REFRESH DONE")
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

