local isInMarker = false
local menuIsOpen = false

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = GetDistanceBetweenCoords(playerCoords, Config.NPC.x, Config.NPC.y, Config.NPC.z, true)

        if distance <= 2.0 then
            isInMarker = true
            DrawMarker(2, Config.NPC.x, Config.NPC.y, Config.NPC.z - 0.98, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 200, false, false, 2, true, false, false, false)
        else
            isInMarker = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = GetDistanceBetweenCoords(playerCoords, Config.NPC.x, Config.NPC.y, Config.NPC.z, true)

        if isInMarker and not menuIsOpen then
            DrawText3D(Config.NPC.x, Config.NPC.y, Config.NPC.z + 0.25, "[E] " .. Config.Messages.MenuPrompt, 0.4)

            if IsControlJustReleased(0, 38) then -- Touche E
                OpenMenu()
            end
        end
    end
end)

function OpenMenu()
    menuIsOpen = true
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'amount_menu', {
        title = Config.Messages.MenuTitle,
    }, function(data, menu)
        local amount = tonumber(data.value)

        if not amount or amount <= 0 then
            TriggerEvent('notification', Config.Messages.InvalidAmount, 2)
            return
        end

        menu.close()
        TriggerServerEvent('blanchiment:cleanMoney', amount)
        TriggerEvent('notification', Config.Messages.CleaningInProgress, 1)
        Citizen.Wait(Config.CleaningCooldown * 1000)
        menuIsOpen = false
    end, function(data, menu)
        menu.close()
        menuIsOpen = false
    end)
end

function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * scale
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
