QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem(baTu.ItemAdi, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('baTu-kiyafetcantasi:PutClotheBagDown', source)
    Player.Functions.RemoveItem(baTu.ItemAdi, 1)
end)

RegisterNetEvent('baTu-kiyafetcantasi:addShoppingbag')
AddEventHandler('baTu-kiyafetcantasi:addShoppingbag', function(object)
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem(baTu.ItemAdi, 1)
end)

function YollamakeDC(title, message, color)
    local embed = {
        {
            ["title"] = title,
            ["description"] = message,
            ["color"] = color,
            ["footer"] = {
                ["text"] = os.date('%Y-%m-%d %H:%M:%S'),
            },
        }
    }
    PerformHttpRequest(baTu.WebhookURL, function(err, text, headers) end, 'POST', json.encode({ username = 'Kıyafet Çantası Log', embeds = embed }), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('baTu-kiyafetcantasi:PutClotheBagDown')
AddEventHandler('baTu-kiyafetcantasi:PutClotheBagDown', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local discordId = nil
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordId = v
        end
    end
    
    local message = "Açan Kişi ID: " .. source .. "\nAçan Kişi Adı: " .. Player.PlayerData.charinfo.firstname .. "\nAçan Kişi Soyadı:" .. Player.PlayerData.charinfo.lastname .. "\nAçan Kişi License ID: " .. Player.PlayerData.license .. "\nAçan Kişi Discord ID: " .. (discordId or "Bulunamadı")
    YollamakeDC("Kıyafet Çantası Açıldı", message, 3066993)
end)
