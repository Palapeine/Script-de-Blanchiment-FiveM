ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('blanchiment:cleanMoney')
AddEventHandler('blanchiment:cleanMoney', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        return
    end

    local playerMoney = xPlayer.getAccount('black_money').money

    if playerMoney < amount then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1Erreur:', 'Vous n\'avez pas assez d\'argent sale.' } })
        return
    end

    local cleanAmount = math.floor(amount * Config.CleaningRate)
    local newCleanMoney = playerMoney - amount
    local newDirtyMoney = xPlayer.getAccount('money').money + cleanAmount

    xPlayer.setAccountMoney('black_money', newCleanMoney)
    xPlayer.setAccountMoney('money', newDirtyMoney)

    TriggerClientEvent('chat:addMessage', source, { args = { '^2Succès:', string.format(Config.Messages.CleaningSuccess, amount, cleanAmount) } })
end)
