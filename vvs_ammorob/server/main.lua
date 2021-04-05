local police = 0
local timeout = 600 * 1000
local getMin = 7000
local getMax = 12000
local SeizureActive = 0

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('vvs_ammorob:start')
AddEventHandler('vvs_ammorob:start', function()
    local copsOnDuty = 0
	local Players = ESX.GetPlayers()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local accountMoney = 0
	accountMoney = xPlayer.getAccount('bank').money
    if SeizureActive == 0 then
	for i = 1, #Players do
        local xPlayer = ESX.GetPlayerFromId(Players[i])
        if xPlayer["job"]["name"] == "police" then
            TriggerClientEvent('vvs_ammorob:setblip', Players[i])
            TriggerClientEvent('esx:showAdvancedNotification', Players[i], 'Zgloszenie', 'Attack', 'Alarm on*!', 'CHAR_AMMUNATION', 3)
            copsOnDuty = copsOnDuty + 1
        end
    end
    if copsOnDuty >= police then
        TriggerClientEvent("vvs_ammorob:zaczynasie", _source)
        Restart()
    else
        TriggerClientEvent('esx:showNotification', _source, '~r~It necessary ~g~'..police.. '~r~ officers to start the robbery.')
	end
    else
        TriggerClientEvent('esx:showNotification', _source, '~r~The window already been robbed!')
    end
end)

function Restart()
    SeizureActive = 1
    Wait(timeout)
    SeizureActive = 0
end

RegisterServerEvent('vvs_ammorob:dajklamke')
AddEventHandler('vvs_ammorob:dajklamke', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local powodzenie = math.random(0, 250)
    if powodzenie >= 125 then
        xPlayer.addWeapon('weapon_pistol', 1)
    end
end)
    
RegisterServerEvent('vvs_ammorob:seizures')
AddEventHandler('vvs_ammorob:seizures', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sianko = math.random(getMin,getMax)
    Wait(2000)
end)
