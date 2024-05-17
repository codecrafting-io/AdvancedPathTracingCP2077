local Utils = require("Modules/Utils")
local GameHUD = require("Modules/GameHUD")
local GameUI = require("Modules/GameUI")
local Cron = require("Modules/Cron")
local GameSettings = {}
local gameRestrictions = {
    "GameplayRestriction.NoCameraControl",
    "GameplayRestriction.NoMovement",
    "GameplayRestriction.NoCombat",
    "GameplayRestriction.NoZooming",
    "GameplayRestriction.NoScanning",
    "GameplayRestriction.NoJump",
    "GameplayRestriction.NoPhone",
    "GameplayRestriction.NoWorldInteractions",
    "GameplayRestriction.NoPhotoMode"
}

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
    for _, v in next, settings do
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

local function isFPPMale()
    local femaleMatch = string.find(tostring(GetPlayer():GetResolvedGenderName()), "Female")

    return not femaleMatch
end

--Requires AMM and TPP mod
function GameSettings.RemoveFPPHead()
    local slot = TweakDBID.new('AttachmentSlots.TppHead')

    --Remove Headgear
    Game.GetScriptableSystemsContainer():Get(CName.new('TakeOverControlSystem')):EnablePlayerTPPRepresenation(false)
    Game.GetTransactionSystem():RemoveItemFromSlot(GetPlayer(), slot, true, true, true)

end

local function equipItem(name, slot)
    local GameItemID = GetSingleton('gameItemID')
    local itemID = GameItemID:FromTDBID(TweakDBID.new(name))
    local slot = TweakDBID.new("AttachmentSlots." .. slot)

    if not (Game.GetTransactionSystem():HasItem(GetPlayer(), itemID)) then
        Game.AddToInventory(name, 1)
    end

    Game.GetTransactionSystem():AddItemToSlot(GetPlayer(), slot, itemID)
end

--Requires AMM and TPP mod
function GameSettings.AddFPPHead()
    GameSettings.RemoveFPPHead()

    --Add Headgear
    local tpp = ActivateTPPRepresentationEvent.new()
    local player = GetPlayer()
    tpp.playerController = player
    player:QueueEvent(tpp)

    Cron.After(0.10, function()
        if isFPPMale() then
            equipItem("Items.CharacterCustomizationMaHead", "TppHead")
        else
            equipItem("Items.CharacterCustomizationWaHead", "TppHead")
        end
    end)
end

function GameSettings.RefreshGame(timeout)
    local x = GameSettings.Get('/controls/fppcameramouse', 'FPP_MouseX')
    local y = GameSettings.Get('/controls/fppcameramouse', 'FPP_MouseY')

    Utils.DebugMessage("Refreshing the game")
    GameHUD.ShowMessage("REFRESHING")

    --Camera Movement
    GameSettings.Set('/controls/fppcameramouse', 'FPP_MouseX', 0)
    GameSettings.Set('/controls/fppcameramouse', 'FPP_MouseY', 0)

    GameSettings.SetTimeDilation(0.0)
    for _, v in ipairs(gameRestrictions) do
        GameSettings.ApplyGameStatus(v)
    end

    Cron.After(timeout, function()
        GameSettings.Set('/controls/fppcameramouse', 'FPP_MouseX', x)
        GameSettings.Set('/controls/fppcameramouse', 'FPP_MouseY', y)

        for _, v in ipairs(gameRestrictions) do
            GameSettings.RemoveGameStatus(v)
        end

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

