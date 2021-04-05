local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
  
ESX						= nil
local PlayerData		= {}
local RobberyPlace = {x = 18.17876, y = -1107.7885, z = 29.7970}
local ready = 0
local ready1 = 0
local ready2 = 0
local ready3 = 0
local ready4 = 0
local ready5 = 0
local ready6 = 0
local register = 0
local rabowanie = 0
local player = PlayerPedId()

CreateThread(function() while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end

function loadAnimDict(dict)  
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

CreateThread(function() while true do Wait(0)
        local plyCoords = GetEntityCoords(PlayerPedId(), false) 
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, RobberyPlace.x, RobberyPlace.y, RobberyPlace.z)
        if dist <= 4.0 then
            DrawMarker(25, RobberyPlace.x, RobberyPlace.y, RobberyPlace.z-0.90, 0, 0, 0, 0, 0, 0, 1.301, 1.3001, 1.3001, 0, 205, 250, 200, 0, 0, 0, 0)
        else
            Wait(1500)
        end
        if dist <= 1.0 then
            DrawText3D(RobberyPlace.x, RobberyPlace.y, RobberyPlace.z, "~g~[E]~r~ To start the robbery!")
            if IsControlJustPressed(0, Keys['E']) then
                TriggerServerEvent('vvs_ammorob:start')
				Wait(500)
            end
        end
    end
end)

CreateThread(function() while true do Wait(0)
        local plyCoords = GetEntityCoords(PlayerPedId(), false) 
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, RobberyPlace.x, RobberyPlace.y, RobberyPlace.z)
        if rabowanie == 1 then
            if dist >= 20.0 then
                rabowanie = 0
                DisplayHelpText('~r~Robbery aborted!')
                PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
                RemoveBlip(blipRobbery)
            end
        end
    end
end)

RegisterNetEvent('vvs_ammorob:zaczynasie')
AddEventHandler('vvs_ammorob:zaczynasie', function()
    ready = 1
    ready1 = 1
    ready2 = 1
    ready3 = 1
    ready4 = 1
    ready5 = 1
    ready6 = 1
    register = 1
    rabowanie = 1
    NotifyRobbery()
end)

CreateThread(function() while true do Wait(0)
        if rabowanie == 1 then
        if ready == 1 then
        if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 17.0893, -1111.87463, 29.90, true) < 1.0 ) then
            DrawText3D(17.0893, -1111.87463, 29.90, "~g~[E]~r~ To break the window!")
            if IsControlJustPressed(0, Keys['E']) then
                exports['progressBars']:startUI(5000, "Breaking the window...")
                if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                    RequestNamedPtfxAsset("scr_jewelheist")
                end
                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                    Wait(0)
                end
                SetPtfxAssetNextCall("scr_jewelheist")
                StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", 17.1250, -1111.64855, 29.90, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                loadAnimDict( "missheist_jewel" ) 
                TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                Wait(5000)
                ClearPedTasksImmediately(PlayerPedId())
                TriggerServerEvent('vvs_ammorob:dajklamke')
                PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                ready = 0
            end
        end
        end
        if ready1 == 1 then
            if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 17.9565, -1109.76269, 29.90, true) < 1.0 ) then
                DrawText3D(17.9565, -1109.76269, 29.90, "~g~[E]~r~ To break the window!")
                if IsControlJustPressed(0, Keys['E']) then
                    exports['progressBars']:startUI(5000, "Breaking the window...")
                    if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                        RequestNamedPtfxAsset("scr_jewelheist")
                    end
                    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                        Wait(0)
                    end
                    SetPtfxAssetNextCall("scr_jewelheist")
                    StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", 17.1250, -1111.64855, 29.90, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                    loadAnimDict( "missheist_jewel" ) 
                    TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                    Wait(5000)
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerServerEvent('vvs_ammorob:dajklamke')
                    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    ready1 = 0
                end
            end
        end
        if ready2 == 1 then
            if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 20.609334, -1105.844238, 29.90, true) < 1.0 ) then
                DrawText3D(20.609334, -1105.844238, 29.90, "~g~[E]~r~ To break the window!")
                if IsControlJustPressed(0, Keys['E']) then
                    exports['progressBars']:startUI(5000, "Breaking the window...")
                    if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                        RequestNamedPtfxAsset("scr_jewelheist")
                    end
                    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                        Wait(0)
                    end
                    SetPtfxAssetNextCall("scr_jewelheist")
                    StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", 17.1250, -1111.64855, 29.90, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                    loadAnimDict( "missheist_jewel" ) 
                    TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                    Wait(5000)
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerServerEvent('vvs_ammorob:dajklamke')
                    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    ready2 = 0
                end
            end
        end
        if ready3 == 1 then
            if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 23.0467, -1107.88732, 29.90, true) < 1.0 ) then
                DrawText3D(23.0467, -1107.88732, 29.90, "~g~[E]~r~ To break the window!")
                if IsControlJustPressed(0, Keys['E']) then
                    exports['progressBars']:startUI(5000, "Breaking the window...")
                    if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                        RequestNamedPtfxAsset("scr_jewelheist")
                    end
                    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                        Wait(0)
                    end
                    SetPtfxAssetNextCall("scr_jewelheist")
                    StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", 17.1250, -1111.64855, 29.90, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                    loadAnimDict( "missheist_jewel" ) 
                    TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                    Wait(5000)
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerServerEvent('vvs_ammorob:dajklamke')
                    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    ready3 = 0
                end
            end
        end
        if ready4 == 1 then
            if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 20.609334, -1105.844238, 29.90, true) < 1.0 ) then
                DrawText3D(20.609334, -1105.844238, 29.90, "~g~[E]~r~ To break the window!")
                if IsControlJustPressed(0, Keys['E']) then
                    exports['progressBars']:startUI(5000, "Breaking the window...")
                    if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                        RequestNamedPtfxAsset("scr_jewelheist")
                    end
                    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                        Wait(0)
                    end
                    SetPtfxAssetNextCall("scr_jewelheist")
                    StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", 17.1250, -1111.64855, 29.90, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                    loadAnimDict( "missheist_jewel" ) 
                    TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                    Wait(5000)
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerServerEvent('vvs_ammorob:dajklamke')
                    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    ready4 = 0
                end
            end
        end
        if ready5 == 1 then
            if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 22.3, -1106.11, 29.90, true) < 1.0 ) then
                DrawText3D(22.3, -1106.11, 29.90, "~g~[E]~r~ To break the window!")
                if IsControlJustPressed(0, Keys['E']) then
                    exports['progressBars']:startUI(5000, "Breaking the window...")
                    local player = PlayerPedId()
                    if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                        RequestNamedPtfxAsset("scr_jewelheist")
                    end
                    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                        Wait(0)
                    end
                    SetPtfxAssetNextCall("scr_jewelheist")
                    StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", 22.3, -1106.11, 29.90, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                    loadAnimDict( "missheist_jewel" ) 
                    TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                    Wait(5000)
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerServerEvent('vvs_ammorob:dajklamke')
                    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    ready5 = 0
                end
            end
        end
        if ready6 == 1 then
            if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 23.26, -1109.49, 29.90, true) < 1.0 ) then
                DrawText3D(23.26, -1109.49, 29.90, "~g~[E]~r~ To break the window!")
                if IsControlJustPressed(0, Keys['E']) then
                    exports['progressBars']:startUI(5000, "Breaking the window...")
                    if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                        RequestNamedPtfxAsset("scr_jewelheist")
                    end
                    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                        Wait(0)
                    end
                    SetPtfxAssetNextCall("scr_jewelheist")
                    StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", 23.26, -1109.49, 29.90, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                    loadAnimDict( "missheist_jewel" ) 
                    TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                    Wait(5000)
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerServerEvent('vvs_ammorob:dajklamke')
                    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    ready6 = 0
                end
            end
        end
        if register == 1 then
            if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 23.7521, -1105.9556, 29.90, true) < 1.0 ) then
                DrawText3D(23.55, -1106.63, 29.90, "~g~[E]~r~ Rob register")
                DisplayHelpText('~y~Get the money out of the register!')
                if IsControlJustPressed(0, Keys['E']) then
                    exports['progressBars']:startUI(20000, "Putting money in bag...")
                    ZabieranieSiana()
                    register = 0
                end
            end
        end
        if ready == 0 and ready1 == 0 and ready2 == 0 and ready3 == 0 and ready4 == 0 and ready5 == 0 and ready6 and register == 0 then
            rabowanie = 0
            DisplayHelpText('~r~Ammounation Robbery Started!')
        end
    end
end
end)

function NotifyRobbery()
    PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
    local czas = 0.550
    SetNotificationTextEntry("STRING")
    AddTextComponentString("The Ammunition robbery started!")
    Citizen.InvokeNative(0x1E6611149DB3DB6B, "CHAR_AMMUNATION", "CHAR_AMMUNATION", true, 1, "Ammunation Shop", "~o~Robbery starting", czas)
    DrawNotification_4(false, true)
end

function ZabieranieSiana()
    RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
    while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
    Wait(50)
    end
    local PedCoords = GetEntityCoords(PlayerPedId())
    torba = CreateObject(GetHashKey('prop_cs_heist_bag_02'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
    AttachEntityToEntity(torba, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
    TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
    FreezeEntityPosition(PlayerPedId(), true)
    Wait(20000)
    DeleteEntity(torba)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    SetPedComponentVariation(PlayerPedId(), 5, 45, 0, 2)
    TriggerServerEvent("vvs_ammorob:napadskonczony")
    Wait(2500)
end
