QBCore = exports['qb-core']:GetCoreObject()

local bag = false

exports.ox_target:addModel(Config.propadi, {
    {
        event = 'baTu-kiyafetcantasi:pickupShoppingbag',
        icon = 'fas fa-hand-holding',
        label = Config.Dil.AlCanta,
    },
    {
        event = 'baTu-kiyafetcantasi:CheckForOutfits',
        icon = 'fas fa-shopping-basket',
        label = Config.Dil.AcCanta,
    },
    {
        event = 'baTu-kiyafetcantasi:moove',
        icon = 'fas fa-shopping-basket',
        label = Config.Dil.tasiyorsunbrem,
    }
})

RegisterNetEvent('baTu-kiyafetcantasi:PutClotheBagDown')
AddEventHandler('baTu-kiyafetcantasi:PutClotheBagDown', function()
    local coords = GetEntityCoords(PlayerPedId())
    coords = coords + vector3(0.0, 0.5, -0.93)
    local heading = GetEntityHeading(PlayerPedId())

    if lib.progressBar({
        duration = 1000,
        label = Config.Dil.yerlestir,
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            dict = 'random@domestic',
            clip = 'pickup_low',
        },
    }) then
        bag = true
        QBCore.Functions.SpawnObject(Config.propadi, coords, function(obj)
            Wait(50)
            SetEntityHeading(obj, heading)
        end)
    end
end)

RegisterNetEvent('baTu-kiyafetcantasi:CheckForOutfits')
AddEventHandler('baTu-kiyafetcantasi:CheckForOutfits', function()
    if not isTimeoutActive then
        isTimeoutActive = true

        SetTimeout(Config.BeklemeSuresi * 60 * 1000, function()
            isTimeoutActive = false
        end)
        

        if Config.Kiyafetmenusu == 'fivem-appearance' then
            exports['fivem-appearance']:openWardrobe(openWardrobe)
        elseif Config.Kiyafetmenusu == 'illenium-appearance' then
            TriggerEvent('illenium-appearance:client:openOutfitMenu')
        end
    else
        lib.notify({ title = 'Kıyafet Çantası', description = 'Giysi çantasını bir kez açabilirsiniz '..Config.BeklemeSuresi..' Dakikan Kaldı', type = 'error' })
    end
end)

RegisterNetEvent('baTu-kiyafetcantasi:pickupShoppingbag')
AddEventHandler('baTu-kiyafetcantasi:pickupShoppingbag', function()
    local object = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.5, GetHashKey(Config.propadi))
    if object ~= 0 then
        NetworkRequestControlOfEntity(object)
        while not NetworkHasControlOfEntity(object) do
            Wait(10)
        end
        TriggerServerEvent('baTu-kiyafetcantasi:addShoppingbag', object)
        DeleteObject(object)
    else
        lib.notify({ title = 'Kıyafet Çantası', description = 'Yakınlarda çanta bulunamadı.', type = 'error' })
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('Script ' .. resourceName .. ' Basladai.')
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('Script ' .. resourceName .. ' Script Durdu.')
end)
