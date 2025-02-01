local Debug = require("Modules/Debug")
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

Debug:SetLogLevel(settings.debug and Debug.INFO or Debug.ERROR)

---Apply TweakDB status effect
---@param effect string
function GameSettings.ApplyGameStatus(effect)
    local player = GetPlayer()
    local entityID = player:GetEntityID()
    local recordID = player:GetRecordID()

    Game.GetStatusEffectSystem():ApplyStatusEffect(entityID, effect, recordID, entityID)
end

---Remove TweakDB status effect
---@param effect string
function GameSettings.RemoveGameStatus(effect)
    Game.GetStatusEffectSystem():RemoveStatusEffect(GetPlayer():GetEntityID(), effect)
end

---Get Game engine or settings value
---@param category any
---@param name any
---@return string
function GameSettings.Get(category, name)
    if string.find(category, '/') == 1 then
        return Game.GetSettingsSystem():GetVar(category, name):GetValue()
    else
        return GameOptions.Get(category, name)
    end
end

---Get Game settings index value
---@param category any
---@param name any
---@return string | nil
function GameSettings.GetIndex(category, name)
    if string.find(category, '/') == 1 then
        return Game.GetSettingsSystem():GetVar(category, name):GetIndex()
    end

    return nil
end

---Set Game settings index value
---@param category any
---@param name any
---@param index any
function GameSettings.SetIndex(category, name, index)
    if string.find(category, '/') == 1 and type(index) == 'number' then
        Game.GetSettingsSystem():GetVar(category, name):SetIndex(index)
    end
end

---Set Game engine or settings value
---@param category any
---@param name any
---@param value any
function GameSettings.Set(category, name, value)
    if string.find(category, '/') == 1 then
        Game.GetSettingsSystem():GetVar(category, name):SetValue(value)
    else
        GameOptions.Set(category, name, value)
    end
end

---Set multiple engine or settings value
---@param settings table
function GameSettings.SetAll(settings)
    for _, v in next, settings do
        GameSettings.Set(v.category, v.name, v.value)
    end
end

---Check if is possible to time skip in game now
---@return boolean
function GameSettings.CanTimeSkip()
    local player = GetPlayer()

    return player and GameTimeUtils.CanPlayerTimeSkip(player)
end

---Check if can refresh game now. Mode won't refresh in a limited gameplay scene or if still refresing
---@return boolean
function GameSettings.CanRefresh()
    return not GameUI.IsScene() and not Game.GetTimeSystem():IsTimeDilationActive()
end

---Check if current Game character is male
---@return boolean
local function isFPPMale()
    local femaleMatch = string.find(tostring(GetPlayer():GetResolvedGenderName()), "Female")

    return not femaleMatch
end

---Remove character head. Requires AMM and TPP mod
function GameSettings.RemoveFPPHead()
    local slot = TweakDBID.new('AttachmentSlots.TppHead')

    --Remove Headgear
    Game.GetScriptableSystemsContainer():Get(CName.new('TakeOverControlSystem')):EnablePlayerTPPRepresenation(false)
    Game.GetTransactionSystem():RemoveItemFromSlot(GetPlayer(), slot, true, true, true)

end

---Equipe Game item to AttachmentSlots
---@param name CName | string
---@param slot string
local function equipItem(name, slot)
    local GameItemID = GetSingleton('gameItemID')
    local itemID = GameItemID:FromTDBID(TweakDBID.new(name))
    local slot = TweakDBID.new("AttachmentSlots." .. slot)

    if not (Game.GetTransactionSystem():HasItem(GetPlayer(), itemID)) then
        Game.AddToInventory(name, 1)
    end

    Game.GetTransactionSystem():AddItemToSlot(GetPlayer(), slot, itemID)
end

---Add character head. Requires AMM and TPP mod
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

---Refresh game by apply multiple restriction effects. Delay can be applied to time stop
---@param timeout number
---@param delay number
function GameSettings.RefreshGame(timeout, delay, events)
    local x = GameSettings.Get('/controls/fppcameramouse', 'FPP_MouseX')
    local y = GameSettings.Get('/controls/fppcameramouse', 'FPP_MouseY')

    events('beforeRefresh')
    Debug:Info("Refreshing the game")
    GameHUD.ShowMessage("REFRESHING")

    --Camera Movement
    GameSettings.Set('/controls/fppcameramouse', 'FPP_MouseX', 0)
    GameSettings.Set('/controls/fppcameramouse', 'FPP_MouseY', 0)

    for _, v in ipairs(gameRestrictions) do
        GameSettings.ApplyGameStatus(v)
    end

    Cron.After(delay, function()
        GameSettings.SetTimeDilation(0.0)

        Cron.After(timeout, function()
            GameSettings.Set('/controls/fppcameramouse', 'FPP_MouseX', x)
            GameSettings.Set('/controls/fppcameramouse', 'FPP_MouseY', y)

            for _, v in ipairs(gameRestrictions) do
                GameSettings.RemoveGameStatus(v)
            end

            GameSettings.UnsetTimeDilation()
            GameHUD.ShowMessage("REFRESH DONE")
            Debug:Info("Refreshing done")
            events('afterRefresh')
        end)
    end)
end

---Set Game time dilation in seconds
---@param time number
function GameSettings.SetTimeDilation(time)
    Game.GetTimeSystem():SetTimeDilation("RefreshPause", time)
end

---Unset Game time dilation
function GameSettings.UnsetTimeDilation()
    Game.GetTimeSystem():UnsetTimeDilation("RefreshPause")
end

---Check if is currently raining in the game
---@return boolean
function GameSettings.IsRaining()
    return Game.GetWeatherSystem():GetRainIntensity() > 0 and true or false
end

---Check if character is indoors area
---@return boolean
function GameSettings.IsIndoors()
    return IsEntityInInteriorArea(GetPlayer())
end

---Check if Ray Reconstrution is enabled
---@return boolean
function GameSettings.HasDLSSD()
    local dlssdSetting = Game.GetSettingsSystem():GetVar("/graphics/presets", "DLSS_D")

    return dlssdSetting and dlssdSetting:GetValue() or false
end

---Check if Path Tracing is enabled
---@return boolean
function GameSettings.HasPathTracing()
    local ptSetting = GameSettings.Get("/graphics/raytracing", "RayTracedPathTracing")

    return ptSetting and true or false
end

return GameSettings

